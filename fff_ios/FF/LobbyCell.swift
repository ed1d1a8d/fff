//
//  LobbyCell.swift
//  FF
//
//  Created by Jing Lin on 8/27/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit

class LobbyCell: UITableViewCell {
    
    let container = FView(baseColor: UIColor.orange)
    let nameLabel = FLabel(text: "",
                           font: UIFont.systemFont(ofSize: 18.0),
                           color: UIColor.black)
    let distLabel = FLabel(text: "",
                           font: UIFont.systemFont(ofSize: 18.0),
                           color: UIColor.black)
    
    init(data: FriendData) {
        super.init(style: .default, reuseIdentifier: "lobbyCell")
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.selectionStyle = .none
        
        let distance = data.distance * 1.6 / 1000
        
        self.nameLabel.text = data.friendName
        self.distLabel.text = String(format: "%.2fm", distance)
        self.distLabel.textAlignment = .right
        
        self.container.layer.cornerRadius = 10
        self.container.clipsToBounds = true
        
        self.container.addSubview(self.nameLabel)
        self.container.addSubview(self.distLabel)
        self.contentView.addSubview(self.container)
        
        addConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addConstraints() {
        self.container.addConstraints(FConstraint.paddingPositionConstraints(view: self.nameLabel, sides: [.left, .top, .bottom], padding: 25))
        self.container.addConstraint(FConstraint.fillXConstraints(view: self.nameLabel, widthRatio: 0.6))
        
        self.container.addConstraints(FConstraint.paddingPositionConstraints(view: self.distLabel, sides: [.right, .top, .bottom], padding: 25))
        self.container.addConstraint(FConstraint.fillXConstraints(view: self.distLabel, widthRatio: 0.4))
        
        self.contentView.addConstraints(FConstraint.paddingPositionConstraints(view: self.container, sides: [.left, .right], padding: 45))
        self.contentView.addConstraint(FConstraint.paddingPositionConstraint(view: self.container, side: .top, padding: 0))
        self.contentView.addConstraint(FConstraint.paddingPositionConstraint(view: self.container, side: .bottom, padding: 30))
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if (highlighted) {
            self.container.backgroundColor = self.container.darkerColor
        } else {
            self.container.backgroundColor = self.container.baseColor
        }
    }
    
}
