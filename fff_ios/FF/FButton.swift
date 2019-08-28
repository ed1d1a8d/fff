//
//  FButton.swift
//  FF
//
//  Created by Jing Lin on 8/27/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit

class FButton: UIButton {
    
    init(titleText: String) {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false

        self.backgroundColor = UIColor.red
        self.setTitle(titleText, for: .normal)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
