//
//  PostsNavigator.swift
//  PostApp
//
//  Created by Norberto Vasconcelos on 11/11/2018.
//  Copyright © 2018 Vasconcelos. All rights reserved.
//

import Foundation
import Domain

protocol PostsNavigator {
    func toPosts()
    func toPost(_ post: PopulatedPost?)
}

class DefaultPostsNavigator: PostsNavigator {
    
    var postsUseCase: PostsUseCase
    var usersUseCase: UsersUseCase
    var commentsUseCase: CommentsUseCase
    var navigationController: UINavigationController
    
    init(postsUseCase: PostsUseCase,
         usersUseCase: UsersUseCase,
         commentsUseCase: CommentsUseCase,
         navigationController: UINavigationController) {
        self.postsUseCase = postsUseCase
        self.usersUseCase = usersUseCase
        self.commentsUseCase = commentsUseCase
        self.navigationController = navigationController
    }
    
    func toPosts() {
        let postsViewModel = PostsViewModel(postsUseCase: postsUseCase,
                                            usersUseCase: usersUseCase,
                                            commentsUseCase: commentsUseCase,
                                            navigator: self)
        
        let postsViewController = PostsViewController()
        postsViewController.viewModel = postsViewModel
        
        navigationController.pushViewController(postsViewController, animated: true)
    }
    
    func toPost(_ post: PopulatedPost?) {
        if let _post = post {
            let navigator = DefaultPostDetailNavigator(navigationController: navigationController)
            let postDetailViewModel = PostDetailViewModel(populatedPost: _post, navigator: navigator)
            let postDetailViewController = PostDetailViewController()
            postDetailViewController.viewModel = postDetailViewModel
            
            navigationController.pushViewController(postDetailViewController, animated: true)
        }
    }
}
