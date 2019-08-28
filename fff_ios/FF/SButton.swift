//
//  SButton.swift
//  FF
//
//  Created by Jing Lin on 8/28/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit

class SButton: UIButton {
    
    let baseColor = UIColor.orange.lighter(by: 20)
    let darkerColor = UIColor.orange
    
    convenience init(titleText: String) {
        self.init(titleText: titleText,
                  font: UIFont.systemFont(ofSize: 16),
                  titleInsets: UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10))
    }
    
    convenience init(titleText: String, font: UIFont) {
        self.init(titleText: titleText,
                  font: font,
                  titleInsets: UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10))
    }
    
    init(titleText: String, font: UIFont, titleInsets: UIEdgeInsets) {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.backgroundColor = self.baseColor
        self.setTitle(titleText, for: .normal)
        self.titleLabel!.font = font
        self.titleEdgeInsets = titleInsets
        
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override var intrinsicContentSize: CGSize {
        let contentSize = super.intrinsicContentSize
        return CGSize(width: contentSize.width + self.titleEdgeInsets.left + self.titleEdgeInsets.right,
                      height: contentSize.height + self.titleEdgeInsets.top + self.titleEdgeInsets.bottom)
    }
    
}
