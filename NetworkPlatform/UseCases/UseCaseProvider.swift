//
//  UseCaseProvider.swift
//  NetworkPlatform
//
//  Created by Norberto Vasconcelos on 11/11/2018.
//  Copyright © 2018 Vasconcelos. All rights reserved.
//

import Foundation
import Domain

public final class UseCaseProvider: Domain.UseCaseProvider {
    
    let networkProvider: NetworkProvider
    
    public init() {
        self.networkProvider = NetworkProvider()
    }
    
    public func makePostsUseCase() -> Domain.PostsUseCase {
        return PostsUseCase(network: networkProvider.makePostsNetwork())
    }
    
    public func makeUsersUseCase() -> Domain.UsersUseCase {
        return UsersUseCase(network: networkProvider.makeUsersNetwork())
    }
    
    public func makeCommentsUseCase() -> Domain.CommentsUseCase {
        return CommentsUseCase(network: networkProvider.makeCommentsNetwork())
    }
    
}
