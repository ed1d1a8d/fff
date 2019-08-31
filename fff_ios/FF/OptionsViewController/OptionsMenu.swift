//
//  OptionsMenu.swift
//  FF
//
//  Created by Jing Lin on 8/30/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit

class OptionsMenu: UIView {
    
    let optionsMenu = FImageView(name: "menuIcon", height: 28.0)
    
    init() {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.layer.cornerRadius = OptionsVC.menu / 2
        self.clipsToBounds = true
        
        self.backgroundColor = Colors.nav
        
        self.addSubview(self.optionsMenu)
        addConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addConstraints() {
        self.addConstraints(FConstraint.centerAlignConstraints(firstView: self, secondView: self.optionsMenu))
        self.addConstraint(FConstraint.constantConstraint(view: self, attribute: .width, value: OptionsVC.menu))
        self.addConstraint(FConstraint.constantConstraint(view: self, attribute: .height, value: OptionsVC.menu))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.backgroundColor = Colors.navDown
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.backgroundColor = Colors.nav
    }
    
}


