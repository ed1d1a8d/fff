//
//  KeyboardButton.swift
//  FF
//
//  Created by Jing Lin on 8/28/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit

class KeyboardButton: UIButton {
    
    init() {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = Keyboard.SendButton.color
        self.layer.cornerRadius = Keyboard.SendButton.diameter / 2.0
        
        self.contentMode = .center
        self.setImage(Keyboard.SendButton.icon, for: .normal)
        
        self.imageEdgeInsets = UIEdgeInsets(top: Keyboard.SendButton.iconPadding,
                                            left: Keyboard.SendButton.iconPadding,
                                            bottom: Keyboard.SendButton.iconPadding,
                                            right: Keyboard.SendButton.iconPadding)
        addConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addConstraints() {
        self.addConstraint(FConstraint.constantConstraint(view: self, attribute: .height, value: Keyboard.SendButton.diameter))
        self.addConstraint(FConstraint.constantConstraint(view: self, attribute: .width, value: Keyboard.SendButton.diameter))
    }
    
}
