//
//  Comment.swift
//  Domain
//
//  Created by Norberto Vasconcelos on 11/11/2018.
//  Copyright © 2018 Vasconcelos. All rights reserved.
//

import Foundation

public struct Comment: Codable {
    
    var postId: Int
    var commentId: Int
    var name: String
    var email: String
    var body: String
    
    private enum CodingKeys: String, CodingKey {
        case postId
        case commentId = "id"
        case name
        case email
        case body
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        postId = try container.decode(Int.self, forKey: .postId)
        commentId = try container.decode(Int.self, forKey: .commentId)
        name = try container.decode(String.self, forKey: .name)
        email = try container.decode(String.self, forKey: .email)
        body = try container.decode(String.self, forKey: .body)
    }
}
