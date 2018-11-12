//
//  TitleDescriptionView.swift
//  PostApp
//
//  Created by Norberto Vasconcelos on 12/11/2018.
//  Copyright © 2018 Vasconcelos. All rights reserved.
//

import Foundation
import Cartography

enum ViewType {
    case prominent
    case regular
    case subdued
}

class TitleDescriptionView: UIView {
    
    var type: ViewType = .regular
    let lblTitle: UILabel = UILabel()
    let lblDescription: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    convenience init(type: ViewType) {
        self.init()
        self.type = type
        backgroundColor = UIColor.clear
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupView() {
        
        lblTitle.textColor = UIColor.black
        lblTitle.textAlignment = .left
        lblTitle.numberOfLines = 0
        
        lblDescription.textColor = UIColor.black
        lblDescription.textAlignment = .left
        lblDescription.numberOfLines = 0
        
        switch type {
        case .prominent:
            lblTitle.font = UIFont(name: "HelveticaNeue-Bold", size: 24)
            lblDescription.font = UIFont(name: "HelveticaNeue-Regular", size: 14)
            break
        case .regular:
            lblTitle.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
            lblDescription.font = UIFont(name: "HelveticaNeue-Regular", size: 12)
            break
        case .subdued:
            lblTitle.font = UIFont(name: "HelveticaNeue-Regular", size: 12)
            lblTitle.textAlignment = .right
            lblDescription.font = UIFont(name: "HelveticaNeue-Light", size: 12)
            lblDescription.textAlignment = .right
            break
        }
        
        addSubview(lblTitle)
        addSubview(lblDescription)
        
        constrain(lblTitle, lblDescription) {
            lblTitle, lblDescription in
            if let superview = lblTitle.superview {
                lblTitle.top == superview.top
                lblTitle.leading == superview.leading + 8
                lblTitle.trailing == superview.trailing - 8
                
                lblDescription.top == lblTitle.bottom + 4
                lblDescription.bottom == superview.bottom
                lblDescription.leading == superview.leading + 8
                lblDescription.trailing == superview.trailing - 8
            }
        }
    }
}
