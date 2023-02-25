//
//  MainEndPoint.swift
//  JsonPlaceholder
//
//  Created by Timur on 7/1/23.
//

import Foundation

enum MainEndPoint {
    case getAllUsers
    case getAllAlbums(id: Int)
    case getAllImages(id: Int)
    case getSingleImage(urlString: String)
}

extension MainEndPoint: EndPointType {
    
    var mainPath: String {
        ""
    }
    
    var path: String {
        switch self {
        case .getAllUsers: return "/users"
        case .getAllAlbums(let id): return "/users/\(id)/albums"
        case .getAllImages(let id): return "/albums/\(id)/photos"
        case .getSingleImage: return ""
        }
    }

    var httpMethod: HTTPMethod {
        switch self {
        default: return .GET
        }
    }

    var task: HTTPTask {
        switch self {
        default: return .request()
        }
    }
}
