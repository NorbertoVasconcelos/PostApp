//
//  PostsViewModel.swift
//  PostApp
//
//  Created by Norberto Vasconcelos on 11/11/2018.
//  Copyright © 2018 Vasconcelos. All rights reserved.
//

import Foundation
import Domain
import RxSwift
import RxCocoa

final class PostsViewModel: ViewModelType {
    
    struct Input {
        let trigger: Driver<Void>
        let selection: Driver<IndexPath>
    }
    
    struct Output {
        let fetching: Driver<Bool>
        let posts: Driver<[Post]>
        let selectedPost: Driver<Post>
        let error: Driver<Error>
    }
    
    private let useCase: PostsUseCase
    private let navigator: PostsNavigator
    
    init(useCase: PostsUseCase,
         navigator: PostsNavigator) {
        self.useCase = useCase
        self.navigator = navigator
    }
    
    func transform(input: PostsViewModel.Input) -> PostsViewModel.Output {
        
        return Output()
    }
}
