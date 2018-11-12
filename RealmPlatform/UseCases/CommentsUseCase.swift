//
//  CommentsUseCase.swift
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

final class CommentsUseCase<Repository>: Domain.CommentsCacheUseCase where Repository: AbstractRepository, Repository.T == Comment {
    
    private let repository: Repository
    
    init(repository: Repository) {
        self.repository = repository
    }
    
    func comments() -> Observable<[Comment]> {
        print("Getting comments.")
        return repository.queryAll()
    }
    
    func comments(for postId: Int) -> Observable<[Comment]> {
        return repository.queryAll().map { comments in
            comments.filter { postId == $0.postId }
        }
    }
    
    func save(comment: Comment) -> Observable<Void> {
        return repository.save(entity: comment)
    }
    
    func delete(comment: Comment) -> Observable<Void> {
        return repository.delete(entity: comment)
    }
}
