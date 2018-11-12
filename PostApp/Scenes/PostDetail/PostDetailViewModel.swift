//
//  PostDetailViewModel.swift
//  PostApp
//
//  Created by Norberto Vasconcelos on 12/11/2018.
//  Copyright © 2018 Vasconcelos. All rights reserved.
//

import Foundation
import Domain
import RxSwift
import RxCocoa

final class PostDetailViewModel: ViewModelType {
    
    struct Input {
        let trigger: Driver<Void>
        let back: Driver<Void>
    }
    
    struct Output {
        let populatedPost: Driver<PopulatedPost>
        let back: Driver<Void>
        let error: Driver<Error>
    }
    
    var populatedPost: PopulatedPost
    var navigator: PostDetailNavigator
    
    init(populatedPost: PopulatedPost, navigator: PostDetailNavigator) {
        self.populatedPost = populatedPost
        self.navigator = navigator
    }
    
    func transform(input: PostDetailViewModel.Input) -> PostDetailViewModel.Output {
        let errorTracker = ErrorTracker()
        
        let post = input.trigger.flatMapLatest { _ in
            return Driver.just(self.populatedPost)
        }
        
        let back = input.back.do(onNext: {
            self.navigator.toPosts()
        })
        
        return Output(populatedPost: post,
                      back: back,
                      error: errorTracker.asDriver())
    }
}
