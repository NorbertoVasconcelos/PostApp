//
//  PostsUseCase.swift
//  Domain
//
//  Created by Norberto Vasconcelos on 11/11/2018.
//  Copyright © 2018 Vasconcelos. All rights reserved.
//

import Foundation
import RxSwift

public protocol PostsUseCase {
    func posts() -> Observable<[Post]>
    func post(with id: Int) -> Observable<Post>
}

public protocol PostsCacheUseCase: PostsUseCase {
    func posts() -> Observable<[Post]>
    func post(with id: Int) -> Observable<Post>
    func save(post: Post) -> Observable<Void>
    func delete(post: Post) -> Observable<Void>
}
