//
//  UseCaseProvider.swift
//  RealmPlatform
//
//  Created by Norberto Vasconcelos on 12/11/2018.
//  Copyright © 2018 Vasconcelos. All rights reserved.
//

import Foundation
import Domain
import Realm
import RealmSwift

public final class UseCaseProvider: Domain.UseCaseProvider {
    
    private let configuration: Realm.Configuration
    
    public init(configuration: Realm.Configuration = Realm.Configuration()) {
        self.configuration = configuration
    }
    
    public func makePostsUseCase() -> Domain.PostsUseCase {
        let repository = Repository<Post>(configuration: configuration)
        return PostsUseCase(repository: repository) as PostsCacheUseCase
    }
    
    public func makeUsersUseCase() -> Domain.UsersUseCase {
        let repository = Repository<User>(configuration: configuration)
        return UsersUseCase(repository: repository) as UsersCacheUseCase
    }
    
    public func makeCommentsUseCase() -> Domain.CommentsUseCase {
        let repository = Repository<Comment>(configuration: configuration)
        return CommentsUseCase(repository: repository) as CommentsCacheUseCase
    }
}
