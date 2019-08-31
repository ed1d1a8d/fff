//
//  OptionsView.swift
//  FF
//
//  Created by Jing Lin on 8/30/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit

class OptionsNavbar: UIView {
    
    let menu = OptionsMenu()
    
    init() {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.isUserInteractionEnabled = true
//        self.backgroundColor = UIColor.cyan
        
        self.addSubview(self.menu)
        addConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addConstraints() {
        self.addConstraint(FConstraint.constantConstraint(view: self, attribute: .height, value: OptionsVC.navbarHeight))
        
        self.addConstraint(FConstraint.equalConstraint(firstView: self.menu, secondView: self, attribute: .centerY))
        self.addConstraint(FConstraint.paddingPositionConstraint(view: self.menu, side: .left, padding: 20))
        
    }
    
}
