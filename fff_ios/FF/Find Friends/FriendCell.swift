//
//  FriendCell.swift
//  FF
//
//  Created by Stella Yang on 8/30/19.

import UIKit

class FriendCell: UITableViewCell {
    
    let container = FView(baseColor: UIColor.white)
    let nameLabel = FLabel(text: "",
                           font: UIFont.systemFont(ofSize: 18.0),
                           color: UIColor.black)
    let username = FLabel(text: "",
                           font: UIFont.systemFont(ofSize: 12.0),
                           color: UIColor.lightGray)
                            
    init(data: FriendData) {
        super.init(style: .default, reuseIdentifier: "friendCell")
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.selectionStyle = .none
                
        self.nameLabel.text = data.friendName
        self.username.text = "@" + data.friendID
        
        self.container.clipsToBounds = true
        
        self.container.addSubview(self.nameLabel)
        self.container.addSubview(self.username)
        self.contentView.addSubview(self.container)
        
        addConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addConstraints() {
        self.container.addConstraints(FConstraint.paddingPositionConstraints(view: self.nameLabel, sides: [.left, .top, .right], padding: 0))
        
        self.container.addConstraint(FConstraint.verticalSpacingConstraint(upperView: self.nameLabel, lowerView: self.username, spacing: 0))
        self.container.addConstraints(FConstraint.paddingPositionConstraints(view: self.username, sides: [.left, .bottom, .right], padding: 0))

        self.contentView.addConstraints(FConstraint.paddingPositionConstraints(view: self.container, sides: [.left, .right], padding: 25))
        self.contentView.addConstraint(FConstraint.paddingPositionConstraint(view: self.container, side: .top, padding: 10))
        self.contentView.addConstraint(FConstraint.paddingPositionConstraint(view: self.container, side: .bottom, padding: 10))
    }
    
}
