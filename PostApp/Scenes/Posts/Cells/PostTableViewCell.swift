//
//  PostTableViewCell.swift
//  PostApp
//
//  Created by Norberto Vasconcelos on 12/11/2018.
//  Copyright © 2018 Vasconcelos. All rights reserved.
//

import UIKit
import Domain
import Cartography

class PostTableViewCell: UITableViewCell {

    var container: UIView = UIView()
    var author: TitleSubtitleView = TitleSubtitleView()
    var post: TitleDescriptionView = TitleDescriptionView()
    var lblNumComments: UILabel = UILabel()
    
    func bind(_ viewModel: PostCellModel) {
        backgroundColor = UIColor.clear
        
        container.layer.cornerRadius = 8
        container.layer.masksToBounds = true
        container.backgroundColor = UIColor.white
        
        author.lblTitle.text = viewModel.username
        author.lblSubtitle.text = viewModel.companyName
        
        post.lblTitle.text = viewModel.title
        post.lblDescription.text = viewModel.body
        
        lblNumComments.text = "Comments: \(viewModel.numberOfComments)"
        lblNumComments.font = UIFont(name: "HelveticaNeue-Light", size: 12.0)
        lblNumComments.textAlignment = .right
        
        addSubview(container)
        container.addSubview(author)
        container.addSubview(post)
        container.addSubview(lblNumComments)
        
        constrain(container) {
            if let superview = $0.superview {
                $0.top == superview.top + 8
                $0.bottom == superview.bottom - 8
                $0.leading == superview.leading + 8
                $0.trailing == superview.trailing - 8
            }
        }
        
        constrain(author, post, lblNumComments) {
            author, post, comments in
            if let containerSuperview = author.superview {
                author.top == containerSuperview.top
                author.leading == containerSuperview.leading
                author.trailing == containerSuperview.trailing
                
                post.top == author.bottom + 24
                post.leading == containerSuperview.leading
                post.trailing == containerSuperview.trailing
                
                comments.top == post.bottom + 24
                comments.bottom == containerSuperview.bottom
                comments.leading == containerSuperview.leading
                comments.trailing == containerSuperview.trailing
            }
        }
    }
}
