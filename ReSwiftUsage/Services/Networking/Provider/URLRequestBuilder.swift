//
//  URLRequestBuilder.swift
//  JsonPlaceholder
//
//  Created by Timur on 7/1/23.
//

import Foundation
import UIKit

protocol URLRequestBuilder {
    func build(with endPoint: EndPointType, _ imageData: Data?, _ imageFieldName: String?) throws -> URLRequest
}

enum BuildRequestError: Error {
    case emptyStore
    case generateURL
}

class URLRequestBuilderImpl: URLRequestBuilder {
    let configuration = Configuration()
    
    func build(with endPoint: EndPointType, _ imageData: Data?, _ imageFieldName: String?) throws -> URLRequest {
        
        var url: URL? = URL(string: configuration.host)
        
        if !endPoint.mainPath.isEmpty {
            url?.appendPathComponent(endPoint.mainPath)
        }
        
        guard let mainURL = url else { throw BuildRequestError.generateURL }
        
        var validURL = mainURL
        if endPoint.path.contains("?") {
            validURL = URL(string: mainURL.absoluteString + endPoint.path) ?? mainURL
        } else {
            validURL = mainURL.appendingPathComponent(endPoint.path)
        }
        
        var request = URLRequest(url: validURL,
                                 cachePolicy: .reloadIgnoringLocalCacheData,
                                 timeoutInterval: endPoint.timeout)
        
        request.httpMethod = endPoint.httpMethod.rawValue
        
        // For uploading images
        if let imageData = imageData, let fieldName = imageFieldName {
            let boundary = "Boundary-\(UUID().uuidString)"
            request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

            let httpBody = NSMutableData()
            httpBody.append(convertFileData(fieldName: fieldName,
                                            fileName: "imagename.jpg",
                                            mimeType: "image/jpeg",
                                            fileData: imageData,
                                            using: boundary))
            httpBody.appendString("--\(boundary)--")
            request.httpBody = httpBody as Data
        }
        
        makeDefaultHeader(request: &request)
        addHeaders(endPoint.headers, request: &request)
        
        try configurateParameters(forTask: endPoint.task, request: &request)
        print("\(request.httpMethod ?? "-") \(request.url?.absoluteString ?? "-")")
        if let body = request.httpBody {
            print(String(data: body, encoding: .utf8) ?? "-")
        }
        return request
    }
    
    private func addHeaders(_ additionalHeaders: HTTPHeaders?, request: inout URLRequest) {
        guard let headers = additionalHeaders else { return }
        for (key, value) in headers {
            request.setValue(value, forHTTPHeaderField: key)
        }
//        request.setValue("ru", forHTTPHeaderField: "Accept-Language")
//
//        request.setValue("ios", forHTTPHeaderField: "os")
//        request.setValue("\(UIDevice.current.systemVersion)", forHTTPHeaderField: "os_version")
//        request.setValue("\(AppVersionData.appVersion)", forHTTPHeaderField: "app_version")
    }
    
    private func setTimeout(_ timeout: TimeInterval?, request: inout URLRequest) {
        guard let timeout = timeout else { return }
        request.timeoutInterval = timeout
    }
    
    private func configurateParameters(forTask task: HTTPTask, request: inout URLRequest) throws {
        switch task {
        case .request(let urlParams, let bodyParams, let additionalHeaders, let timeout):
            if let params = bodyParams {
                try JSONParameterEncoder.encode(urlRequest: &request, with: params)
            }
            if let params = urlParams {
                try URLParameterEncoder.encode(urlRequest: &request, with: params)
            }
            
            addHeaders(additionalHeaders, request: &request)
            setTimeout(timeout, request: &request)
        }
    }
    
    private func makeDefaultHeader(request: inout URLRequest) {
//        var defaultHeaders = ["channel": "2"]
//        if let appVersion = Bundle.main.releaseVersionNumber,
//           let buildVersion = Bundle.main.buildVersionNumber {
//            defaultHeaders["AppVersion"] = "\(buildVersion)|\(appVersion)"
//        }
//        addHeaders(defaultHeaders, request: &request)
    }
    
    private func convertFileData(fieldName: String, fileName: String, mimeType: String, fileData: Data, using boundary: String) -> Data {
        let data = NSMutableData()
        data.appendString("--\(boundary)\r\n")
        data.appendString("Content-Disposition: form-data; name=\"\(fieldName)\"; filename=\"\(fileName)\"\r\n")
        data.appendString("Content-Type: \(mimeType)\r\n\r\n")
        data.append(fileData)
        data.appendString("\r\n")
        return data as Data
    }
}

extension NSMutableData {
    func appendString(_ string: String) {
        if let data = string.data(using: .utf8) {
            self.append(data)
        }
    }
}

