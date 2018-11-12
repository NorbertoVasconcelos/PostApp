//
//  RMAddress.swift
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


final class RMAddress: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var street: String = ""
    @objc dynamic var suite: String = ""
    @objc dynamic var city: String = ""
    @objc dynamic var zipcode: String = ""
    @objc dynamic var geo: RMCoordinate?
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

extension RMAddress {
    static var id: Attribute<String> { return Attribute("id")}
    static var street: Attribute<String> { return Attribute("street")}
    static var suite: Attribute<String> { return Attribute("suite")}
    static var city: Attribute<String> { return Attribute("city")}
    static var zipcode: Attribute<String> { return Attribute("zipcode")}
    static var geo: Attribute<Coordinate> { return Attribute("geo")}
}

extension RMAddress: DomainConvertibleType {
    func asDomain() -> Address {
        return Address(street: street,
                       suite: suite,
                       city: city,
                       zipcode: zipcode,
                       geo: geo?.asDomain() ?? Coordinate(lat: "", lng: ""))
    }
}

extension Address: RealmRepresentable {
    var id: String {
        return ""
    }
    
    
    func asRealm() -> RMAddress {
        return RMCoordinate.build { object in
            object.id = ""
            object.street = street
            object.suite = suite
            object.city = city
            object.zipcode = zipcode
            object.geo = geo.asRealm()
        }
    }
}
