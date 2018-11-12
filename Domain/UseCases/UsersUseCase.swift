//
//  UserUseCase.swift
//  Domain
//
//  Created by Norberto Vasconcelos on 11/11/2018.
//  Copyright © 2018 Vasconcelos. All rights reserved.
//

import Foundation
import RxSwift

public protocol UsersUseCase {
    func users() -> Observable<[User]>
    func user(with id: Int) -> Observable<User>
}

public protocol UsersCacheUseCase: UsersUseCase {
    func users() -> Observable<[User]>
    func user(with id: Int) -> Observable<User>
    func save(user: User) -> Observable<Void>
    func delete(user: User) -> Observable<Void>
}
