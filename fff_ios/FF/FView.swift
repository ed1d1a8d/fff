//
//  FView.swift
//  FF
//
//  Created by Jing Lin on 8/27/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit

class FView: UIView {
    
    let baseColor:UIColor
    let darkerColor:UIColor
    
    init(baseColor: UIColor) {
        self.baseColor = baseColor
        self.darkerColor = self.baseColor.darker(by: 20)!
        
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.backgroundColor = self.baseColor
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
