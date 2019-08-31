//
//  MenuDetailView.swift
//  FF
//
//  Created by Jing Lin on 8/30/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit

class OptionsDetailView: UIView {
    
    init() {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.isUserInteractionEnabled = true
        
        self.backgroundColor = Colors.slideMenu
        
        addConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addConstraints() {
        self.addConstraint(FConstraint.constantConstraint(view: self, attribute: .width, value: OptionsVC.dWidth))
        self.addConstraint(FConstraint.constantConstraint(view: self, attribute: .height, value: OptionsVC.dHeight))
    }
    
}
