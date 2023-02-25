//
//  APIProvider.swift
//  JsonPlaceholder
//
//  Created by Timur on 7/1/23.
//

import Foundation
import Combine
//import SwiftyJSON

struct BadRequest: Codable {
    let errorCode: String?
    let errorMessage: String?
}

enum APIProviderError: Error {
    case badRequest(payload: BadRequest? = nil)
    case authenticationError
    case forbidden
    case server
    case decode(description: Data)
    case timeout
    case connection
    case unknown
}

extension APIProviderError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .timeout, .connection:
            return "Пожалуйста, повторите позже"
        case .authenticationError:
            return "authenticationError"
        case .badRequest:
            return "badRequest"
        case let .decode(data):
//            let json = JSON(data)
            return "Decode Problem: \(data)"
        case .forbidden:
            return "forbidden"
        case .server:
            return "server"
        case .unknown:
            return "unknown"
        }
    }
}

struct APIProvider<EndPoint: EndPointType> {
    
    enum StubMode {
        case never, immediate
    }
    
    private let stubMode: StubMode
    let requestBuilder: URLRequestBuilder = URLRequestBuilderImpl()
    
    init(stubMode: StubMode = .never) {
        self.stubMode = stubMode
    }
    
    func perform(_ endPoint: EndPoint, _ imageData: Data? = nil, _ imageFieldName: String? = nil) -> AnyPublisher<Void, APIProviderError> {
        do {
            let request = try requestBuilder.build(with: endPoint, imageData, imageFieldName)
            return try configurateSession(urlRequest: request, stub: endPoint.testData)
                .dataTaskPublisher(for: request)
                .mapURLError
                .mapResponse
                .receive(on: RunLoop.main)
                .toVoid
                .mapError { $0 as! APIProviderError }
                .handleEvents(receiveCompletion: { completion in
                    print(completion)
                })
                .eraseToAnyPublisher()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    func perform<D: Decodable>(_ endPoint: EndPoint, _ imageData: Data? = nil, _ imageFieldName: String? = nil) -> AnyPublisher<D, APIProviderError> {
        do {
            let request = try requestBuilder.build(with: endPoint, imageData, imageFieldName)
            return try configurateSession(urlRequest: request, stub: endPoint.testData)
                .dataTaskPublisher(for: request)
                .mapURLError
                .mapResponse
                .receive(on: RunLoop.main)
                .decode(type: D.self, decoder: JSONDecoder())
                .mapError { error -> APIProviderError in
                    if let err = error as? APIProviderError {
                        return err
                    } else {
                        return .unknown
                    }
                }
                .handleEvents(receiveCompletion: { completion in
                    print(completion)
                })
                .eraseToAnyPublisher()
        } catch {
            fatalError(error.localizedDescription)
        }
    }
    
    private func configurateSession(urlRequest: URLRequest, stub: Data? = nil) throws -> URLSession {
        switch stubMode {
        case .immediate:
            let config = URLSessionConfiguration.ephemeral
            URLProtocolMock.data[urlRequest.url] = stub
            config.protocolClasses = [URLProtocolMock.self]
            return URLSession(configuration: config)
        case .never:
            return URLSession.shared
        }
    }
}

fileprivate extension Publisher where Output == URLSession.DataTaskPublisher.Output {
    
    var mapResponse: Publishers.TryMap<Self, Data> {
        tryMap { (data, response)  in
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                var error: APIProviderError
                switch (response as! HTTPURLResponse).statusCode {
                case 400:
                    error = .badRequest(payload: try? JSONDecoder().decode(BadRequest.self, from: data))
                case 401:
                    error = .authenticationError
                case 403:
                    error = .forbidden
                case 404...500:
                    error = .decode(description: data)
                default:
                    error = .unknown
                }
                throw error
            }
            return data
        }
    }
}

fileprivate extension Publisher where Failure == URLError {
    var mapURLError: Publishers.MapError<Self, APIProviderError> {
        mapError { error -> APIProviderError in
            let nserror = error as NSError
            switch nserror.code {
            case NSURLErrorTimedOut:
                return .timeout
            case NSURLErrorNotConnectedToInternet:
                return .connection
            default:
                return .unknown
            }
        }
    }
}

extension Publisher where Self.Failure == APIProviderError {
    func genericError<T: RawRepresentable>() -> Publishers.MapError<Self, T> where T.RawValue == String {
        Publishers.MapError(upstream: self, { error -> T in
            guard case .badRequest(let data) = error,
                  let code = data?.errorCode,
                  let badRequestError = T(rawValue: code) else {
                guard let unknownError = T(rawValue: "unknown") else {
                    preconditionFailure("Unknown error isn't provided")
                }
                return unknownError
            }
            return badRequestError
        })
    }
}

