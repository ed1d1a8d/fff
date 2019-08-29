//
//  MessageBubble.swift
//  FF
//
//  Created by Jing Lin on 8/28/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit

class MessageBubble: UILabel {
    
    init() {
        super.init(frame: .zero)
        
        self.textAlignment = .left
        self.lineBreakMode = .byWordWrapping
        self.numberOfLines = 0
        
        self.font = Bubble.font
        self.layer.cornerRadius = Bubble.cornerRadius
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: Bubble.vPadding,
                                  left: Bubble.hPadding,
                                  bottom: Bubble.vPadding,
                                  right: Bubble.hPadding)
        super.drawText(in: rect.inset(by: insets))
        
    }
    
    override public var intrinsicContentSize: CGSize {
        var currSize = super.intrinsicContentSize
        currSize.height += Bubble.vPadding * 2
        currSize.width += Bubble.hPadding * 2
        
        return currSize
    }
    
}

