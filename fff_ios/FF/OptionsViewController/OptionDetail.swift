//
//  OptionDetail.swift
//  FF
//
//  Created by Jing Lin on 8/31/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit

class OptionDetail: UIView {
    
    let icon:FImageView
    let vcText:FLabel
    
    init(iconName: String, vcName: String) {
        self.icon = FImageView(name: iconName, height: OptionsVC.optionDetailHeight)
        self.vcText = FLabel(text: vcName,
                             font: OptionsVC.optionDetailFont,
                             color: UIColor.black)
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(self.icon)
        self.addSubview(self.vcText)
        addConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addConstraints() {
        self.addConstraints(FConstraint.paddingPositionConstraints(view: self.icon, sides: [.left, .top, .bottom], padding: 0))
        
        self.addConstraint(FConstraint.horizontalSpacingConstraint(leftView: self.icon, rightView: self.vcText, spacing: 15))
        self.addConstraints(FConstraint.paddingPositionConstraints(view: self.vcText, sides: [.top, .bottom], padding: 0))

    }
    
}
