//
//  SelectionToggle.swift
//  FF
//
//  Created by Jing Lin on 8/28/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit

class SelectionToggle: UIView {
    
    var selection:SelectionDelegate!
    let withFriendButton = SButton(titleText: "a friend",
                                   font: UIFont.systemFont(ofSize: 24))
    let withSomeoneButton = SButton(titleText: "someone new",
                                    font: UIFont.systemFont(ofSize: 24))
    
    init() {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.withFriendButton.addTarget(self, action: #selector(SelectionToggle.selectButton), for: .touchUpInside)
        self.withSomeoneButton.addTarget(self, action: #selector(SelectionToggle.selectButton), for: .touchUpInside)
        
        self.addSubview(self.withFriendButton)
        self.addSubview(self.withSomeoneButton)
        
        addConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addConstraints() {
        self.addConstraints(FConstraint.paddingPositionConstraints(view: self.withFriendButton, sides: [.left, .top, .right], padding: 0))
        self.addConstraint(FConstraint.verticalSpacingConstraint(upperView: self.withFriendButton, lowerView: self.withSomeoneButton, spacing: 25))
        self.addConstraints(FConstraint.paddingPositionConstraints(view: self.withSomeoneButton, sides: [.left, .bottom, .right], padding: 0))
    }
    
    @objc func selectButton(sender: AnyObject) {
        let selectedButton = sender as! SButton
        let otherButton = selectedButton == self.withFriendButton ? self.withSomeoneButton : self.withFriendButton
        
        selectedButton.backgroundColor = selectedButton.darkerColor
        otherButton.backgroundColor = selectedButton.baseColor
        
        self.selection.showFindButton()
    }
    
}
