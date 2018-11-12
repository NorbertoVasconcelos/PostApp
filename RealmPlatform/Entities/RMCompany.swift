//
//  RMCompany.swift
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


final class RMCompany: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var catchPhrase: String = ""
    @objc dynamic var bs: String = ""
    
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

extension RMCompany {
    static var id: Attribute<String> { return Attribute("id")}
    static var name: Attribute<String> { return Attribute("name")}
    static var catchPhrase: Attribute<Int> { return Attribute("catchPhrase")}
    static var bs: Attribute<Int> { return Attribute("bs")}
}

extension RMCompany: DomainConvertibleType {
    func asDomain() -> Company {
        return Company(name: name, catchPhrase: catchPhrase, bs: bs)
    }
}

extension RMCompany: RealmRepresentable {
    
    func asRealm() -> RMCompany {
        return RMCompany.build { object in
            object.id = ""
            object.name = name
            object.catchPhrase = catchPhrase
            object.bs = bs
        }
    }
}
