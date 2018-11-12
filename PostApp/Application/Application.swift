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

final class Application {
    static let shared = Application()
    
    private let networkUseCaseProvider: Domain.UseCaseProvider
    
    private init() {
        self.networkUseCaseProvider = NetworkPlatform.UseCaseProvider()
    }
    
    func configureMainInterface(in window: UIWindow) {
        
        let navigationController = UINavigationController()
        navigationController.setNavigationBarHidden(true, animated: false)
        let postsNavigator = DefaultPostsNavigator(postsUseCase: networkUseCaseProvider.makePostsUseCase(),
                                                   usersUseCase: networkUseCaseProvider.makeUsersUseCase(),
                                                   commentsUseCase: networkUseCaseProvider.makeCommentsUseCase(),
                                                   navigationController: navigationController)
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
        postsNavigator.toPosts()
    }
}
