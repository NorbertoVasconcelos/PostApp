//
//  CommentsUseCase.swift
//  NetworkPlatform
//
//  Created by Norberto Vasconcelos on 11/11/2018.
//  Copyright © 2018 Vasconcelos. All rights reserved.
//

import Foundation
import Domain
import RxSwift

public final class CommentsUseCase: Domain.CommentsUseCase {
    
    let network: CommentsNetwork
    
    init(network: CommentsNetwork) {
        self.network = network
    }

    public func comments() -> Observable<[Comment]> {
        return network.comments()
    }
    
    public func comments(for postId: Int) -> Observable<[Comment]> {
        return network.comments(for: postId)
    }
}
