//
//  CommentsUseCase.swift
//  Domain
//
//  Created by Norberto Vasconcelos on 11/11/2018.
//  Copyright © 2018 Vasconcelos. All rights reserved.
//

import Foundation
import RxSwift

public protocol CommentsUseCase {
    func comments() -> Observable<[Comment]>
    func comments(for postId: Int) -> Observable<[Comment]>
}
