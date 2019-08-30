//
//  FBButton.swift
//  FF
//
//  Created by Jing Lin on 8/30/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit

class FBButton: UIView {
    
    let fbIcon = UIImageView(image: UIImage(named: "fbIcon"))
    let text = FLabel(text: "Login with Facebook",
                      font: LoginVC.buttonFont,
                      color: UIColor.white)
    
    init() {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.fbIcon.translatesAutoresizingMaskIntoConstraints = false
        self.fbIcon.contentMode = .scaleAspectFit
        
        self.text.numberOfLines = 1
        self.backgroundColor = Colors.fb
        self.layer.cornerRadius = 7
        self.clipsToBounds = true
        
        self.addSubview(self.fbIcon)
        self.addSubview(self.text)
        addConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addConstraints() {
        let square = heightForUILabel(text: self.text.text!, font: self.text.font, width: Dimensions.width)
        self.addConstraint(FConstraint.constantConstraint(view: self.fbIcon, attribute: .height, value: square))
        self.addConstraint(FConstraint.constantConstraint(view: self.fbIcon, attribute: .width, value: square))
        
        self.addConstraint(FConstraint.paddingPositionConstraint(view: self.fbIcon, side: .left, padding: 25))
        self.addConstraints(FConstraint.paddingPositionConstraints(view: self.fbIcon, sides: [.top, .bottom], padding: 14))
        
        self.addConstraint(FConstraint.paddingPositionConstraint(view: self.text, side: .right, padding: 25))
        self.addConstraints(FConstraint.paddingPositionConstraints(view: self.text, sides: [.top, .bottom], padding: 14))
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.backgroundColor = Colors.fbDown
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        self.backgroundColor = Colors.fb
    }
    
}
