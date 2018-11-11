//
//  User.swift
//  Domain
//
//  Created by Norberto Vasconcelos on 11/11/2018.
//  Copyright © 2018 Vasconcelos. All rights reserved.
//

import Foundation

public struct Post: Codable {
    
    var userId: Int
    var postId: Int
    var title: String
    var body: String
    
    private enum CodingKeys: String, CodingKey {
        case userId
        case postId = "id"
        case title
        case body
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        userId = try container.decode(Int.self, forKey: .userId)
        postId = try container.decode(Int.self, forKey: .postId)
        title = try container.decode(String.self, forKey: .title)
        body = try container.decode(String.self, forKey: .body)
    }
}