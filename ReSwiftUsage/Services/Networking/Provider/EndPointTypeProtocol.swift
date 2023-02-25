//
//  EndPointTypeProtocol.swift
//  JsonPlaceholder
//
//  Created by Timur on 7/1/23.
//

import Foundation

typealias HTTPHeaders = [String: String]

enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

enum HTTPTask {
    case request(url: Parameters? = nil, body: Parameters? = nil, additionalHeaders: HTTPHeaders? = nil, timeout: TimeInterval? = nil)
}

protocol EndPointType {
    var mainPath: String { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
    var timeout: TimeInterval { get }
    var testData: Data? { get }
}

extension EndPointType {
    var headers: HTTPHeaders? { nil }
    var timeout: TimeInterval { 60.0 }
    var testData: Data? { nil }
}
