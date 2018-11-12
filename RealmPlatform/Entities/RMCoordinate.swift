//
//  RMCoordinate.swift
//  RealmPlatform
//
//  Created by Norberto Vasconcelos on 11/11/2018.
//  Copyright © 2018 Vasconcelos. All rights reserved.
//

import Foundation
import QueryKit
import Domain
import RealmSwift
import Realm


final class RMCoordinate: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var lat: String = ""
    @objc dynamic var lng: String = ""
    
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

extension RMCoordinate {
    static var id: Attribute<String> { return Attribute("id")}
    static var lat: Attribute<String> { return Attribute("lat")}
    static var lng: Attribute<Int> { return Attribute("lng")}
}

extension RMCoordinate: DomainConvertibleType {
    func asDomain() -> Coordinate {
        return Coordinate(lat: lat, lng: lng)
    }
}

extension RMCoordinate: RealmRepresentable {
    
    func asRealm() -> RMCoordinate {
        return RMCoordinate.build { object in
            object.id = ""
            object.lat = lat
            object.lng = lng
        }
    }
}
