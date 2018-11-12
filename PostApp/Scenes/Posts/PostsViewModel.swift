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
        let combinedPosts: Driver<[PostCellModel?]>
        let selectedPost: Driver<Post>
        let error: Driver<Error>
    }
    
    private let postsUseCase: PostsUseCase
    private let usersUseCase: UsersUseCase
    private let commentsUseCase: CommentsUseCase
    private let navigator: PostsNavigator
    
    init(postsUseCase: PostsUseCase,
         usersUseCase: UsersUseCase,
         commentsUseCase: CommentsUseCase,
         navigator: PostsNavigator) {
        self.postsUseCase = postsUseCase
        self.usersUseCase = usersUseCase
        self.commentsUseCase = commentsUseCase
        self.navigator = navigator
    }
    
    func transform(input: PostsViewModel.Input) -> PostsViewModel.Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        let posts = self.postsUseCase.posts()
            .trackActivity(activityIndicator)
            .trackError(errorTracker)
            .asDriverOnErrorJustComplete()
        
        
        let comments = self.commentsUseCase.comments()
            .trackActivity(activityIndicator)
            .trackError(errorTracker)
            .asDriverOnErrorJustComplete()
        
        let users = self.usersUseCase.users()
            .trackActivity(activityIndicator)
            .trackError(errorTracker)
            .asDriverOnErrorJustComplete()
        
        let combined = Driver.combineLatest(posts, comments, users) {
            posts, comments, users in
                posts.map { post -> PostCellModel? in
                    let filteredUsers = users.filter { post.userId == $0.userId }
                    let filteredComments = comments.filter { post.postId == $0.postId}
                    if let user = filteredUsers.first {
                        return PostCellModel(username: user.username,
                                             companyName: user.company.name,
                                             title: post.title,
                                             body: post.body,
                                             numberOfComments: filteredComments.count)
                    }
                    return nil
                }
            }
        
        let combinedPosts = input.trigger.flatMapLatest { _ in
            return combined
        }
        
        let fetching = activityIndicator.asDriver()
        let errors = errorTracker.asDriver()
        let selectedPost = input.selection.withLatestFrom(posts) {
            indexPath, posts -> Post in
            let selectedPost = posts[indexPath.row]
            self.navigator.toPost(selectedPost)
            return selectedPost
        }
        return Output(fetching: fetching,
                      combinedPosts: combinedPosts,
                      selectedPost: selectedPost,
                      error: errors)
    }
}
