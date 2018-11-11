//
//  CommentsNetwork.swift
//  NetworkPlatform
//
//  Created by Norberto Vasconcelos on 11/11/2018.
//  Copyright © 2018 Vasconcelos. All rights reserved.
//

import Foundation
import RxSwift
import Domain

public final class CommentsNetwork: Domain.CommentsUseCase {
    
    private let network: Network<Comment>
    
    init(network: Network<Comment>) {
        self.network = network
    }

    public func comments(for postId: Int) -> Observable<[Comment]> {
        return network.getItems("comments", for: "postId", id: String(postId))
    }
}
