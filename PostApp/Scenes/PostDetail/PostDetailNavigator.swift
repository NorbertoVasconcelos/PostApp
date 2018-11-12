//
//  PostDetailNavigator.swift
//  PostApp
//
//  Created by Norberto Vasconcelos on 12/11/2018.
//  Copyright © 2018 Vasconcelos. All rights reserved.
//

import Foundation
import Domain

protocol PostDetailNavigator {
    func toPosts()
    func toPost(_ post: Post)
}

class DefaultPostDetailNavigator: PostDetailNavigator {

    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func toPosts() {
        navigationController.popViewController(animated: true)
    }
    
    func toPost(_ post: Post) {
        
    }
}
