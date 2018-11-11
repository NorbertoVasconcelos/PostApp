//
//  Company.swift
//  Domain
//
//  Created by Norberto Vasconcelos on 11/11/2018.
//  Copyright © 2018 Vasconcelos. All rights reserved.
//

import Foundation

public struct Company: Codable {
    
    var name: String
    var catchPhrase: String
    var bs: String
    
    private enum CodingKeys: String, CodingKey {
        case name
        case catchPhrase
        case bs
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        name = try container.decode(String.self, forKey: .name)
        catchPhrase = try container.decode(String.self, forKey: .catchPhrase)
        bs = try container.decode(String.self, forKey: .bs)
    }
}
