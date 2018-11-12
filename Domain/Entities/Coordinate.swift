//
//  Coordinate.swift
//  Domain
//
//  Created by Norberto Vasconcelos on 11/11/2018.
//  Copyright © 2018 Vasconcelos. All rights reserved.
//

import Foundation

public struct Coordinate: Codable {

    public var lat: String
    public var lng: String
    
    private enum CodingKeys: String, CodingKey {
        case lat
        case lng
    }
    
    public init(lat: String, lng: String) {
        self.lat = lat
        self.lng = lng
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        lat = try container.decode(String.self, forKey: .lat)
        lng = try container.decode(String.self, forKey: .lng)
    }    
}
