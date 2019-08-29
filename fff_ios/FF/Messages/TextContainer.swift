//
//  TextContainer.swift
//  FF
//
//  Created by Jing Lin on 8/28/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit

class TextContainer: UITextView {
    
    var containerConstraint:NSLayoutConstraint!
    
    init() {
        super.init(frame: .zero, textContainer: nil)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.alwaysBounceHorizontal = false
        self.showsHorizontalScrollIndicator = false
        self.showsVerticalScrollIndicator = false
        
        self.autocorrectionType = Keyboard.correctionType
        self.keyboardAppearance = Keyboard.appearance
        
        self.tintColor = Keyboard.tintColor
        
        self.font = Keyboard.font
        self.textContainerInset = .zero
        self.contentInset = .zero
        self.textContainer.lineFragmentPadding = 0.0
        
        addConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addConstraints() {
        self.containerConstraint = FConstraint.constantConstraint(view: self, attribute: .height, value: Keyboard.defaultHeight)
        self.addConstraint(self.containerConstraint)
    }
    
    // very important function to prevent UITextView's scroll animation from interfering with the frame changes.
    override func setContentOffset(_ contentOffset: CGPoint, animated: Bool) {
        super.setContentOffset(contentOffset, animated: false)
    }
}


