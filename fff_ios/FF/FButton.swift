//
//  FButton.swift
//  FF
//
//  Created by Jing Lin on 8/27/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit

class FButton: UIButton {
    
    convenience init(titleText: String) {
        self.init(titleText: titleText, font: UIFont.systemFont(ofSize: 16))
    }
    
    init(titleText: String, font: UIFont) {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.setTitleColor(UIColor.black, for: .normal)
        self.backgroundColor = UIColor(red: 255.0/255.0, green: 218/255.0, blue: 147/255.0, alpha: 1)
        self.setTitle(titleText, for: .normal)
        self.titleLabel!.font = font
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
