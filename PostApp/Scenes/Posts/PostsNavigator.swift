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
    func toPost(_ post: Post)
}

class DefaultPostsNavigator: PostsNavigator {
    
    var useCase: PostsUseCase
    var navigationController: UINavigationController
    
    init(useCase: PostsUseCase,
         navigationController: UINavigationController) {
        self.useCase = useCase
        self.navigationController = navigationController
    }
    
    func toPosts() {
        let postsViewModel = PostsViewModel(useCase: useCase, navigator: self)
        
        let postsViewController = PostsViewController()
        postsViewController.viewModel = postsViewModel
        
        navigationController.pushViewController(postsViewController, animated: true)
    }
    
    func toPost(_ post: Post) {
        
    }
}
