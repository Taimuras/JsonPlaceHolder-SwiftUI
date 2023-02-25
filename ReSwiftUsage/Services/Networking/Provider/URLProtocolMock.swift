//
//  URLProtocolMock.swift
//  JsonPlaceholder
//
//  Created by Timur on 7/1/23.
//

import Foundation

class URLProtocolMock: URLProtocol {
    
    static var data: [URL? : Data] = [:]
    
    override class func canInit(with request: URLRequest) -> Bool {
        true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        request
    }
    
    override func startLoading() {
        if let request = request.url {
            if let data = URLProtocolMock.data[request] {
                self.client?.urlProtocol(self, didLoad: data)
                self.client?.urlProtocol(self, didReceive: HTTPURLResponse(url: request,
                                                                           statusCode: 200,
                                                                           httpVersion: nil,
                                                                           headerFields: nil)!,
                                         cacheStoragePolicy: .notAllowed)
            }
        }
        self.client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() { }
    
}
