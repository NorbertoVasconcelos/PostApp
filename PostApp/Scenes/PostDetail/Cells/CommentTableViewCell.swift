//
//  CommentTableViewCell.swift
//  PostApp
//
//  Created by Norberto Vasconcelos on 12/11/2018.
//  Copyright © 2018 Vasconcelos. All rights reserved.
//

import UIKit
import Domain
import Cartography

class CommentTableViewCell: UITableViewCell {

    var container: UIView = UIView()
    var comment: TitleSubtitleView = TitleSubtitleView(type: .regular)
    
    func bind(_ viewModel: Comment) {
        backgroundColor = UIColor.groupTableViewBackground
        
        comment.lblTitle.text = viewModel.name
        comment.lblSubtitle.text = viewModel.body
        
        addSubview(container)
        container.addSubview(comment)

        
        constrain(container) {
            if let superview = $0.superview {
                $0.top == superview.top + 8
                $0.bottom == superview.bottom - 8
                $0.leading == superview.leading + 8
                $0.trailing == superview.trailing - 8
            }
        }
        
        constrain(comment) {
            if let superview = $0.superview {
                $0.top == superview.top
                $0.bottom == superview.bottom
                $0.leading == superview.leading
                $0.trailing == superview.trailing
            }
        }
    }

}
