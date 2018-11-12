//
//  RMPost.swift
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


final class RMPost: Object {
    @objc dynamic var userId: Int = -1
    @objc dynamic var postId: Int = -1
    @objc dynamic var title: String = ""
    @objc dynamic var body: String = ""
    
    override class func primaryKey() -> String? {
        return "postId"
    }
}

extension RMPost {
    static var userId: Attribute<Int> { return Attribute("userId")}
    static var postId: Attribute<Int> { return Attribute("postId")}
    static var title: Attribute<String> { return Attribute("title")}
    static var body: Attribute<String> { return Attribute("body")}
}

extension RMPost: DomainConvertibleType {
    func asDomain() -> Post {
        return Post(userId: userId,
                    postId: postId,
                    title: title,
                    body: body)
    }
}

extension Post: RealmRepresentable {
    var id: String {
        return String(postId)
    }
    
    func asRealm() -> RMPost {
        return RMPost.build { object in
            object.postId = postId
            object.userId = userId
            object.title = title
            object.body = body
        }
    }
}
