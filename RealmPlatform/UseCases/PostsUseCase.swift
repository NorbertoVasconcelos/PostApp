//
//  PostUseCase.swift
//  RealmPlatform
//
//  Created by Norberto Vasconcelos on 12/11/2018.
//  Copyright © 2018 Vasconcelos. All rights reserved.
//

import Foundation
import Domain
import RxSwift
import Realm
import RealmSwift

final class PostsUseCase<Repository>: Domain.PostsCacheUseCase where Repository: AbstractRepository, Repository.T == Post {
    
    
    private let repository: Repository
    
    init(repository: Repository) {
        self.repository = repository
    }
    
    func posts() -> Observable<[Post]> {
        print("Getting posts.")
        return repository.queryAll()
    }
    
    func post(with id: Int) -> Observable<Post> {
        return repository.queryAll().map { posts in
            posts.filter { String(id) == $0.id }.first!
        }
    }
    
    func save(post: Post) -> Observable<Void> {
        return repository.save(entity: post)
    }
    
    func delete(post: Post) -> Observable<Void> {
        return repository.delete(entity: post)
    }
}
