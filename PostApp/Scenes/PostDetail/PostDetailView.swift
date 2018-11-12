//
//  PostDetailView.swift
//  PostApp
//
//  Created by Norberto Vasconcelos on 12/11/2018.
//  Copyright © 2018 Vasconcelos. All rights reserved.
//

import Foundation
import Cartography

final class PostDetailView: UIView {
    
    let btnBack: UIButton = UIButton()
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
        btnBack.setImage(UIImage(named: "arrow_left"), for: .normal)
        
        
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 50))
        headerView.addSubview(btnBack)
        tableView.tableHeaderView = headerView
        addSubview(tableView)
        
        constrain(btnBack) {
            btnBack in
            if let superview = btnBack.superview {
                btnBack.leading == superview.leading + 8
                btnBack.top == superview.top
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
