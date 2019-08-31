//
//  OtherRegButton.swift
//  FF
//
//  Created by Jing Lin on 8/30/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit

class OtherRegButton: UIView {
    
    let text = FLabel(text: "Other registration methods\ncoming soon!",
                      font: LoginVC.buttonFont,
                      color: UIColor.black)
    
    init() {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.text.numberOfLines = 2
        self.text.textAlignment = .center
        
        self.backgroundColor = Colors.reg
        self.layer.cornerRadius = 7
        self.clipsToBounds = true
        
        self.addSubview(self.text)
        addConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addConstraints() {
        self.addConstraints(FConstraint.paddingPositionConstraints(view: self.text, sides: [.left, .right], padding: 25))
        self.addConstraints(FConstraint.paddingPositionConstraints(view: self.text, sides: [.top, .bottom], padding: 14))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.backgroundColor = Colors.regDown
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.backgroundColor = Colors.reg
    }
    
}
