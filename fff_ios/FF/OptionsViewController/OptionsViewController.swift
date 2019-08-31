//
//  OptionsViewController.swift
//  FF
//
//  Created by Jing Lin on 8/30/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit

class OptionsViewController: UIViewController {
    
    let optionsNavbar = OptionsNavbar()
    
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
        self.view.backgroundColor = Colors.background
        
        self.view.addSubview(self.optionsNavbar)
        addConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addConstraints() {
        self.view.addConstraint(FConstraint.paddingPositionConstraint(view: self.optionsNavbar, side: .top, padding: 30))
        self.view.addConstraints(FConstraint.paddingPositionConstraints(view: self.optionsNavbar, sides: [.left, .right], padding: 0))
    }
    
}
