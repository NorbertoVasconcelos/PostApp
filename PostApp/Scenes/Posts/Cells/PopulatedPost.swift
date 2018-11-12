//
//  PostCellViewModel.swift
//  PostApp
//
//  Created by Norberto Vasconcelos on 12/11/2018.
//  Copyright © 2018 Vasconcelos. All rights reserved.
//

import Foundation
import Domain

struct PopulatedPost {
    var post: Post
    var user: User
    var comments: [Comment]
    
    init(post: Post, user: User, comments: [Comment]) {
        self.post = post
        self.user = user
        self.comments = comments
    }
}
