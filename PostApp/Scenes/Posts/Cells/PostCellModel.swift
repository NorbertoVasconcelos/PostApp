//
//  PostCellViewModel.swift
//  PostApp
//
//  Created by Norberto Vasconcelos on 12/11/2018.
//  Copyright © 2018 Vasconcelos. All rights reserved.
//

import Foundation

struct PostCellModel {
    var username: String
    var companyName: String
    var title: String
    var body: String
    var numberOfComments: Int
    
    init(username: String,
         companyName: String,
         title: String,
         body: String,
         numberOfComments: Int) {
        self.username = username
        self.companyName = companyName
        self.title = title
        self.body = body
        self.numberOfComments = numberOfComments
    }
}
