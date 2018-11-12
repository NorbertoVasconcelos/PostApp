//
//  RMComment.swift
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


final class RMComment: Object {
    @objc dynamic var postId: Int = -1
    @objc dynamic var commentId: Int = -1
    @objc dynamic var name: String = ""
    @objc dynamic var email: String = ""
    @objc dynamic var body: String = ""
    
    override class func primaryKey() -> String? {
        return "commentId"
    }
}

extension RMComment {
    static var postId: Attribute<Int> { return Attribute("postId")}
    static var commentId: Attribute<Int> { return Attribute("commentId")}
    static var name: Attribute<String> { return Attribute("name")}
    static var email: Attribute<String> { return Attribute("email")}
    static var body: Attribute<String> { return Attribute("body")}
}

extension RMComment: DomainConvertibleType {
    func asDomain() -> Comment {
        return Comment(postId: postId,
                       commentId: commentId,
                       name: name,
                       email: email,
                       body: body)
    }
}

extension Comment: RealmRepresentable {
    var id: String {
        return String(commentId)
    }    
    
    func asRealm() -> RMComment {
        return RMComment.build { object in
            object.postId = postId
            object.commentId = commentId
            object.name = name
            object.email = email
            object.body = body
        }
    }
}
