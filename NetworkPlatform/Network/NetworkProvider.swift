//
//  NetworkProvider.swift
//  NetworkPlatform
//
//  Created by Norberto Vasconcelos on 11/11/2018.
//  Copyright © 2018 Vasconcelos. All rights reserved.
//

import Foundation
import Domain
import Realm
import RealmSwift
import RxSwift
import RxRealm

final class NetworkProvider {
    private let apiEndpoint: String
    
    public init() {
        apiEndpoint = "http://jsonplaceholder.typicode.com"
    }
    
    public func makePostsNetwork() -> PostsNetwork {
        let network = Network<Post>(apiEndpoint)
        return PostsNetwork(network: network)
    }
    
    public func makeUsersNetwork() -> UsersNetwork {
        let network = Network<User>(apiEndpoint)
        return UsersNetwork(network: network)
    }
    
    public func makeCommentsNetwork() -> CommentsNetwork {
        let network = Network<Comment>(apiEndpoint)
        return CommentsNetwork(network: network)
    }
}
