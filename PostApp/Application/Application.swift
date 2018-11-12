//
//  Application.swift
//  PostApp
//
//  Created by Norberto Vasconcelos on 11/11/2018.
//  Copyright © 2018 Vasconcelos. All rights reserved.
//

import Foundation
import Domain
import NetworkPlatform
import RealmPlatform

final class Application {
    static let shared = Application()
    
    private let networkUseCaseProvider: Domain.UseCaseProvider
    private let realmUseCaseProvider: Domain.UseCaseProvider
    
    private init() {
        self.networkUseCaseProvider = NetworkPlatform.UseCaseProvider()
        self.realmUseCaseProvider = RealmPlatform.UseCaseProvider()
    }
    
    func configureMainInterface(in window: UIWindow) {
        
        let navigationController = UINavigationController()
        navigationController.setNavigationBarHidden(true, animated: false)
        let postsNavigator = DefaultPostsNavigator(postsUseCase: networkUseCaseProvider.makePostsUseCase(),
                                                   usersUseCase: networkUseCaseProvider.makeUsersUseCase(),
                                                   commentsUseCase: networkUseCaseProvider.makeCommentsUseCase(),
                                                   postsCacheUseCase: realmUseCaseProvider.makePostsUseCase() as! PostsCacheUseCase,
                                                   usersCacheUseCase: realmUseCaseProvider.makeUsersUseCase() as! UsersCacheUseCase,
                                                   commentsCacheUseCase: realmUseCaseProvider.makeCommentsUseCase() as! CommentsCacheUseCase,
                                                   navigationController: navigationController)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        postsNavigator.toPosts()
    }
}
