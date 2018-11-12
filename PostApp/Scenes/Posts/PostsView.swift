//
//  PostsView.swift
//  PostApp
//
//  Created by Norberto Vasconcelos on 11/11/2018.
//  Copyright © 2018 Vasconcelos. All rights reserved.
//

import Foundation
import Cartography

final class PostsView: UIView {
    
    var tableView: UITableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupView() {
        let lblTitle = UILabel()
        lblTitle.text = "Posts"
        lblTitle.font = UIFont(name: "HelveticaNeue-Bold", size: 36)
        lblTitle.textColor = UIColor.black
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 80))
        headerView.addSubview(lblTitle)
        tableView.tableHeaderView = headerView
        addSubview(tableView)
        
        constrain(lblTitle) {
            lblTitle in
            if let superview = lblTitle.superview {
                lblTitle.leading == superview.leading + 8
                lblTitle.top == superview.top
            }
        }
        
        constrain(tableView) {
            tableView in
            if let superview = tableView.superview {
                tableView.top == superview.top + 32
                tableView.leading == superview.leading
                tableView.trailing == superview.trailing
                tableView.bottom == superview.bottom
            }
        }
    }
}
