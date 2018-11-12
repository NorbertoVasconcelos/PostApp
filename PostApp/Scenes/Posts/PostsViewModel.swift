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
        let combinedPosts: Driver<[PopulatedPost?]>
        let selectedPost: Driver<PopulatedPost?>
        let error: Driver<Error>
    }
    
    private let postsUseCase: PostsUseCase
    private let usersUseCase: UsersUseCase
    private let commentsUseCase: CommentsUseCase
    private let postsCacheUseCase: PostsCacheUseCase
    private let usersCacheUseCase: UsersCacheUseCase
    private let commentsCacheUseCase: CommentsCacheUseCase
    private let navigator: PostsNavigator
    private var disposeBag: DisposeBag = DisposeBag()
    
    init(postsUseCase: PostsUseCase,
         usersUseCase: UsersUseCase,
         commentsUseCase: CommentsUseCase,
         postsCacheUseCase: PostsCacheUseCase,
         usersCacheUseCase: UsersCacheUseCase,
         commentsCacheUseCase: CommentsCacheUseCase,
         navigator: PostsNavigator) {
        self.postsUseCase = postsUseCase
        self.usersUseCase = usersUseCase
        self.commentsUseCase = commentsUseCase
        self.postsCacheUseCase = postsCacheUseCase
        self.usersCacheUseCase = usersCacheUseCase
        self.commentsCacheUseCase = commentsCacheUseCase
        self.navigator = navigator
    }
    
    func transform(input: PostsViewModel.Input) -> PostsViewModel.Output {
        let activityIndicator = ActivityIndicator()
        let errorTracker = ErrorTracker()
        
        let cachedPosts = self.postsCacheUseCase.posts().asDriverOnErrorJustComplete()
        let cachedUsers = self.usersCacheUseCase.users().asDriverOnErrorJustComplete()
        let cachedComments = self.commentsCacheUseCase.comments().asDriverOnErrorJustComplete()

        let posts = self.postsUseCase.posts()
            .trackActivity(activityIndicator)
            .trackError(errorTracker)
            .asDriver(onErrorDriveWith: { cachedPosts }())
            .do(onNext: {
                let _ = $0.map { self.postsCacheUseCase.save(post: $0).subscribe().disposed(by: self.disposeBag) }
            })
        
        
        let comments = self.commentsUseCase.comments()
            .trackActivity(activityIndicator)
            .trackError(errorTracker)
            .asDriver(onErrorDriveWith: { cachedComments }())
            .do(onNext: {
                let _ = $0.map { self.commentsCacheUseCase.save(comment: $0).subscribe().disposed(by: self.disposeBag) }
            })
        
        let users = self.usersUseCase.users()
            .trackActivity(activityIndicator)
            .trackError(errorTracker)
            .asDriver(onErrorDriveWith: { cachedUsers }())
            .do(onNext: {
                let _ = $0.map { self.usersCacheUseCase.save(user: $0).subscribe().disposed(by: self.disposeBag) }
            })
        
        let combined = Driver.combineLatest(posts, comments, users) {
            posts, comments, users in
                posts.map { post -> PopulatedPost? in
                    let filteredUsers = users.filter { post.userId == $0.userId }
                    let filteredComments = comments.filter { post.postId == $0.postId}
                    if let user = filteredUsers.first {
                        return PopulatedPost(post: post,
                                             user: user,
                                             comments: filteredComments)
                    }
                    return nil
                }
            }
        
        let combinedPosts = input.trigger.flatMapLatest { _ in
            return combined
        }
        
        let fetching = activityIndicator.asDriver()
        let errors = errorTracker.asDriver()
        let selectedPost = input.selection.withLatestFrom(combinedPosts) {
            indexPath, posts -> PopulatedPost? in
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
