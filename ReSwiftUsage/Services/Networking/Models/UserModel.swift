//
//  UserModel.swift
//  JsonPlaceholder
//
//  Created by Timur on 7/1/23.
//

import Foundation

struct UserModel: Codable, Hashable{
    var id: Int?
    var name: String?
    var email: String?
    var address: City?
    
    enum CodingKeys: String, CodingKey{
        case id
        case name
        case email
        case address
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        address = try values.decodeIfPresent(City.self, forKey: .address)
    }
    
    init(id: Int, name: String, email: String){
        self.id = id
        self.name = name
        self.email = email
    }
}

struct City: Codable, Hashable{
    var city: String?
    
    enum CodingKeys: String, CodingKey{
        case city
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        city = try values.decodeIfPresent(String.self, forKey: .city)
    }
}

