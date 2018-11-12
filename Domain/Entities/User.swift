//
//  User.swift
//  Domain
//
//  Created by Norberto Vasconcelos on 11/11/2018.
//  Copyright © 2018 Vasconcelos. All rights reserved.
//

import Foundation

public struct User: Codable {
    
    public var userId: Int
    public var name: String
    public var username: String
    public var email: String
    public var address: Address
    public var phone: String
    public var website: String
    public var company: Company
    
    private enum CodingKeys: String, CodingKey {
        case userId = "id"
        case name
        case username
        case email
        case address
        case phone
        case website
        case company
    }
    
    public init(userId: Int, name: String, username: String, email: String, address: Address, phone: String, website: String, company: Company) {
        self.userId = userId
        self.name = name
        self.username = username
        self.email = email
        self.address = address
        self.phone = phone
        self.website = website
        self.company = company
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
