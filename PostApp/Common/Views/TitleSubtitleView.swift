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
    
    var type: ViewType = .regular
    let lblTitle: UILabel = UILabel()
    let lblSubtitle: UILabel = UILabel()
    
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
        
        lblSubtitle.textColor = UIColor.black
        lblSubtitle.textAlignment = .left
        lblSubtitle.numberOfLines = 0
        
        switch type {
        case .prominent:
            lblTitle.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
            lblSubtitle.font = UIFont(name: "HelveticaNeue-Light", size: 12)
            break
        case .regular:
            lblTitle.font = UIFont(name: "HelveticaNeue-Bold", size: 14)
            lblSubtitle.font = UIFont(name: "HelveticaNeue-Light", size: 12)
            break
        case .subdued:
            lblTitle.font = UIFont(name: "HelveticaNeue-Bold", size: 12)
            lblTitle.textAlignment = .right
            lblSubtitle.font = UIFont(name: "HelveticaNeue-Light", size: 12)
            lblSubtitle.textAlignment = .right
            break
        }
        
        
        
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
