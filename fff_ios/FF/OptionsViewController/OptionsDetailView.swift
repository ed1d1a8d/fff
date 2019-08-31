//
//  MenuDetailView.swift
//  FF
//
//  Created by Jing Lin on 8/30/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit

class OptionsDetailView: UIView {
    
    let fff = FLabel(text: "Free For Food?",
                     font: UIFont.systemFont(ofSize: 28, weight: .medium),
                     color: UIColor.black)
    let lobbyDetail = OptionDetail(iconName: "lobbyIcon", vcName: "Lobby")
    let friendDetail = OptionDetail(iconName: "friendsIcon", vcName: "Friends")
    let logoutDetail = OptionDetail(iconName: "logoutIcon", vcName: "Logout")
    
    init() {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.isUserInteractionEnabled = true
        
        self.backgroundColor = Colors.slideMenu
        
        self.addSubview(self.fff)
        self.addSubview(self.lobbyDetail)
        self.addSubview(self.friendDetail)
        self.addSubview(self.logoutDetail)
        addConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addConstraints() {
        self.addConstraint(FConstraint.constantConstraint(view: self, attribute: .width, value: OptionsVC.dWidth))
        self.addConstraint(FConstraint.constantConstraint(view: self, attribute: .height, value: OptionsVC.dHeight))
        
        self.addConstraint(FConstraint.paddingPositionConstraint(view: self.fff, side: .left, padding: 25))
        let topPadding = Dimensions.height * 0.10
        self.addConstraint(FConstraint.paddingPositionConstraint(view: self.fff, side: .top, padding: topPadding))
        
        var topView:UIView = self.fff
        for view in [self.lobbyDetail, self.friendDetail, self.logoutDetail] {
            self.addConstraints(FConstraint.paddingPositionConstraints(view: view, sides: [.left, .right], padding: 25))
            self.addConstraint(FConstraint.verticalSpacingConstraint(upperView: topView, lowerView: view, spacing: 20))
            
            topView = view
        }
    }
    
}
