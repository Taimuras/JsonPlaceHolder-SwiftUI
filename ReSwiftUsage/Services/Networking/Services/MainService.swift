//
//  MainService.swift
//  JsonPlaceholder
//
//  Created by Timur on 7/1/23.
//

import Foundation
import Combine

protocol MainServiceProtocol{
    func getAllUsers() -> AnyPublisher<[UserModel], APIProviderError>
    func getAllAlbums(id: Int) -> AnyPublisher<[AlbumModel], APIProviderError>
    func getAllImages(id: Int) -> AnyPublisher<[PhotoModel], APIProviderError>
    func getSingleImage(urlString: String) -> AnyPublisher<Data, APIProviderError>
}

class MainService: MainServiceProtocol{
    static let shared = MainService()
    let mainProvider: APIProvider<MainEndPoint>
    
    init(provider: APIProvider<MainEndPoint> = APIProvider()) {
       self.mainProvider = provider
    }
    
    func getAllUsers() -> AnyPublisher<[UserModel], APIProviderError> {
        mainProvider.perform(.getAllUsers)
            .map{ (container: [UserModel]) in
                container
            }
            .mapError{(error: APIProviderError) in
                error
            }
            .eraseToAnyPublisher()
    }
    
    func getAllAlbums(id: Int) -> AnyPublisher<[AlbumModel], APIProviderError> {
        mainProvider.perform(.getAllAlbums(id: id))
            .map{(container: [AlbumModel]) in
                container
            }
            .eraseToAnyPublisher()
    }
    
    func getAllImages(id: Int) -> AnyPublisher<[PhotoModel], APIProviderError> {
        mainProvider.perform(.getAllAlbums(id: id))
            .map{(container: [PhotoModel]) in
                container
            }
            .eraseToAnyPublisher()
    }
    
    func getSingleImage(urlString: String) -> AnyPublisher<Data, APIProviderError> {
        mainProvider.perform(.getSingleImage(urlString: urlString))
            .map{(container: Data) in
                container
            }
            .eraseToAnyPublisher()
    }
}
