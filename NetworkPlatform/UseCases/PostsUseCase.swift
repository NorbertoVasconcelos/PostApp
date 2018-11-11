//
//  PostsUseCase.swift
//  NetworkPlatform
//
//  Created by Norberto Vasconcelos on 11/11/2018.
//  Copyright © 2018 Vasconcelos. All rights reserved.
//

import Foundation
import Domain
import RxSwift

public final class PostsUseCase: Domain.PostsUseCase {
    
    let network: PostsNetwork
    
    init(network: PostsNetwork) {
        self.network = network
    }

    public func posts() -> Observable<[Post]> {
        return network.posts()
    }
    
    public func post(with id: Int) -> Observable<Post> {
        return network.post(with: id)
    }
}
