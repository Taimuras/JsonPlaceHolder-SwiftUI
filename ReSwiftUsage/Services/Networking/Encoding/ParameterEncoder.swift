//
//  ParameterEncoder.swift
//  JsonPlaceholder
//
//  Created by Timur on 7/1/23.
//

import Foundation

typealias Parameters = [String: Any]

protocol ParameterEncoder {
    static func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws
}

enum URLEncodeError: Error {
    case parametersNil
    case missingURL
    case encodingFailed
}
