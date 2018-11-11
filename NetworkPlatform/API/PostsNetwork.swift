//
//  PostsNetwork.swift
//  NetworkPlatform
//
//  Created by Norberto Vasconcelos on 11/11/2018.
//  Copyright © 2018 Vasconcelos. All rights reserved.
//

import Foundation
import RxSwift
import Domain

public final class PostsNetwork: Domain.PostsUseCase {
    
    private let network: Network<Post>
    
    init(network: Network<Post>) {
        self.network = network
    }
    
    public func posts() -> Observable<[Post]> {
        return network.getItems("posts")
    }
    
    public func post(with id: Int) -> Observable<Post> {
        return network.getItem("posts", itemId: String(id))
    }
}
