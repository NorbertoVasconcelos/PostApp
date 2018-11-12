//
//  RMUser.swift
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


final class RMUser: Object {
    @objc dynamic var userId: Int = -1
    @objc dynamic var name: String = ""
    @objc dynamic var username: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var address: RMAddress?
    @objc dynamic var phone: String = ""
    @objc dynamic var website: String = ""
    @objc dynamic var company: RMCompany?
    
    override class func primaryKey() -> String? {
        return "userId"
    }
}

extension RMUser {
    static var userId: Attribute<Int> { return Attribute("userId")}
    static var name: Attribute<String> { return Attribute("name")}
    static var username: Attribute<String> { return Attribute("username")}
    static var email: Attribute<String> { return Attribute("email")}
    static var address: Attribute<RMAddress> { return Attribute("address")}
    static var phone: Attribute<String> { return Attribute("phone")}
    static var website: Attribute<String> { return Attribute("website")}
    static var company: Attribute<RMCompany> { return Attribute("company")}
}

extension RMUser: DomainConvertibleType {
    func asDomain() -> User {
        return User(userId: userId,
                    name: name,
                    username: username,
                    email: email,
                    address: address!.asDomain(),
                    phone: phone,
                    website: website,
                    company: company!.asDomain())
    }
}

extension RMUser: RealmRepresentable {
    var id: String {
        return String(userId)
    }
    
    func asRealm() -> RMUser {
        return RMUser.build { object in
            object.userId = userId
            object.name = name
            object.username = username
            object.email = email
            object.address = address
            object.phone = phone
            object.website = website
            object.company = company
        }
    }
}
