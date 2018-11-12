//
//  TitleDescriptionView.swift
//  PostApp
//
//  Created by Norberto Vasconcelos on 12/11/2018.
//  Copyright © 2018 Vasconcelos. All rights reserved.
//

import Foundation
import Cartography

class TitleDescriptionView: UIView {
    
    let lblTitle: UILabel = UILabel()
    let lblDescription: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupView() {
        
        lblTitle.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
        lblTitle.textColor = UIColor.black
        lblTitle.textAlignment = .left
        
        lblDescription.font = UIFont(name: "HelveticaNeue-Regular", size: 12)
        lblDescription.textColor = UIColor.black
        lblDescription.textAlignment = .left
        lblDescription.numberOfLines = 0
        
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
