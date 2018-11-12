//
//  UsersUseCase.swift
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

final class UsersUseCase<Repository>: Domain.UsersCacheUseCase where Repository: AbstractRepository, Repository.T == User {
    
    
    private let repository: Repository
    
    init(repository: Repository) {
        self.repository = repository
    }
    
    func users() -> Observable<[User]> {
        print("Getting users.")
        return repository.queryAll()
    }
    
    func user(with id: Int) -> Observable<User> {
        return repository.queryAll().map { users in
            users.filter { id == $0.userId }.first!
        }
    }
    
    func save(user: User) -> Observable<Void> {
        return repository.save(entity: user)
    }
    
    func delete(user: User) -> Observable<Void> {
        return repository.delete(entity: user)
    }
}
