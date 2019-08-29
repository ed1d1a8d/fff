//
//  TextPlaceholder.swift
//  FF
//
//  Created by Jing Lin on 8/28/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit

class TextPlaceholder: UITextField {
    
    init() {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let placeholderText = NSAttributedString(string: Keyboard.placeholder,
                                                 attributes: [.foregroundColor: Keyboard.placeholderColor])
        self.attributedPlaceholder = placeholderText
        self.isUserInteractionEnabled = false
        
        addConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addConstraints() {
        self.addConstraint(FConstraint.constantConstraint(view: self, attribute: .height, value: Keyboard.defaultHeight))
    }
    
}
