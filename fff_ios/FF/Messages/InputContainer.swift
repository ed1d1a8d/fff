//
//  InputContainer.swift
//  FF
//
//  Created by Jing Lin on 8/28/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit

class InputContainer: UIView {
    
    let textContainer = TextContainer()
    let textPlaceholder = TextPlaceholder()
    
    let sendButton = KeyboardButton()
    
    init() {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.textContainer.delegate = self
        
        self.addSubview(self.textContainer)
        self.addSubview(self.textPlaceholder)
        self.addSubview(self.sendButton)
        createConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createConstraints() {
        self.addConstraints(FConstraint.paddingPositionConstraints(view: self.textContainer, sides: [.top, .bottom], padding: 15.0))
        self.addConstraint(FConstraint.paddingPositionConstraint(view: self.textContainer, side: .left, padding: 15.0))
        self.addConstraint(FConstraint.horizontalSpacingConstraint(leftView: self.textContainer, rightView: self.sendButton, spacing: 10))
        
        self.addConstraint(FConstraint.paddingPositionConstraint(view: self.sendButton, side: .bottom, padding: 15 - Keyboard.SendButton.buttonpadding / 2))
        self.addConstraint(FConstraint.paddingPositionConstraint(view: self.sendButton, side: .right, padding: 15))
        
        let attrs:[NSLayoutConstraint.Attribute] =  [.left, .top, .right]
        for attr in attrs {
            self.addConstraint(FConstraint.equalConstraint(firstView: self.textContainer, secondView: self.textPlaceholder, attribute: attr))
        }
    }
    
    func fetchText() -> String {
        let text = textContainer.text!
        textContainer.text = ""
        
        self.textPlaceholder.isHidden = false
        self.textContainer.containerConstraint.constant = Keyboard.defaultHeight
        
        return text
    }
    
}

extension InputContainer: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        let width = self.textContainer.bounds.width
        let updatedSize = self.textContainer.sizeThatFits(CGSize(width: width, height: CGFloat.greatestFiniteMagnitude))
        self.textContainer.containerConstraint.constant = min(updatedSize.height, Keyboard.maxHeight)
        
        self.textPlaceholder.isHidden = self.textContainer.text.isEmpty ? false : true
    }
    
}
