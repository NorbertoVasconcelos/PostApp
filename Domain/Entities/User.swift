//
//  User.swift
//  Domain
//
//  Created by Norberto Vasconcelos on 11/11/2018.
//  Copyright © 2018 Vasconcelos. All rights reserved.
//

import Foundation

public struct User: Codable {
    
    var userId: Int
    var name: String
    var username: String
    var email: String
    var address: Address
    var phone: String
    var website: String
    var company: Company
    
    private enum CodingKeys: String, CodingKey {
        case userId
        case name
        case username
        case email
        case address
        case phone
        case website
        case company
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        userId = try container.decode(Int.self, forKey: .userId)
        name = try container.decode(String.self, forKey: .name)
        username = try container.decode(String.self, forKey: .username)
        email = try container.decode(String.self, forKey: .email)
        address = try container.decode(Address.self, forKey: .address)
        phone = try container.decode(String.self, forKey: .phone)
        website = try container.decode(String.self, forKey: .website)
        company = try container.decode(Company.self, forKey: .company)
    }
}
