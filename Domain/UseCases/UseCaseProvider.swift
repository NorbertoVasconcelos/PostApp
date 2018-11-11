//
//  UseCaseProvider.swift
//  Domain
//
//  Created by Norberto Vasconcelos on 11/11/2018.
//  Copyright © 2018 Vasconcelos. All rights reserved.
//

import Foundation

public protocol UseCaseProvider {
    func makePostsUseCase() -> PostsUseCase
}
