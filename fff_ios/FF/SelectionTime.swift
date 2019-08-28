//
//  SelectionTime.swift
//  FF
//
//  Created by Jing Lin on 8/28/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit

class SelectionTime: UIView {
    
    let timeLabel = FLabel()
    let minuteLabel = FLabel()
    
    init() {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        let timeText = attrString(time: 20, forTime: true)
        let minuteText = attrString(time: 20, forTime: false)
        
        self.timeLabel.textAlignment = .center
        self.minuteLabel.textAlignment = .center
        self.timeLabel.attributedText = timeText
        self.minuteLabel.attributedText = minuteText
        
        self.addSubview(self.timeLabel)
        self.addSubview(self.minuteLabel)
        
        addConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addConstraints() {
        self.addConstraints(FConstraint.paddingPositionConstraints(view: self.timeLabel, sides: [.left, .top, .right, .bottom], padding: 0))
        self.addConstraints(FConstraint.paddingPositionConstraints(view: self.minuteLabel, sides: [.left, .top, .right, .bottom], padding: 0))
    }
    
    func attrString(time: Int, forTime: Bool) -> NSAttributedString {
        let attrText = NSMutableAttributedString(
            string: "\(time) minutes",
            attributes: [.font: UIFont.systemFont(ofSize: 24.0)])
        let timeColor = forTime ? UIColor.black : UIColor.clear
        let minuteColor = forTime ? UIColor.clear : UIColor.black
        
        attrText.addAttribute(.foregroundColor, value: timeColor, range: NSRange(location: 0, length: 2))
        attrText.addAttribute(.foregroundColor, value: minuteColor, range: NSRange(location: 2, length: 8))
        
        return attrText
    }
    
    func updateTime(time: Float) {
        let newTimeText = attrString(time: Int(floor(time)), forTime: true)
        self.timeLabel.attributedText = newTimeText
    }
    
}







