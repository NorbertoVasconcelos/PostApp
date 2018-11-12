//
//  TitleSubtitleView.swift
//  PostApp
//
//  Created by Norberto Vasconcelos on 12/11/2018.
//  Copyright © 2018 Vasconcelos. All rights reserved.
//

import Foundation
import Cartography

class TitleSubtitleView: UIView {
    
    let lblTitle: UILabel = UILabel()
    let lblSubtitle: UILabel = UILabel()
    
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
        
        lblSubtitle.font = UIFont(name: "HelveticaNeue-Light", size: 12)
        lblSubtitle.textColor = UIColor.black
        lblSubtitle.textAlignment = .left
        lblSubtitle.numberOfLines = 0
        
        addSubview(lblTitle)
        addSubview(lblSubtitle)
        
        constrain(lblTitle, lblSubtitle) {
            lblTitle, lblSubtitle in
            if let superview = lblTitle.superview {
                lblTitle.top == superview.top
                lblTitle.leading == superview.leading + 8
                lblTitle.trailing == superview.trailing - 8
                
                lblSubtitle.top == lblTitle.bottom + 4
                lblSubtitle.bottom == superview.bottom
                lblSubtitle.leading == superview.leading + 8
                lblSubtitle.trailing == superview.trailing - 8
            }
        }
    }
}
