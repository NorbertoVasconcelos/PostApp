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
