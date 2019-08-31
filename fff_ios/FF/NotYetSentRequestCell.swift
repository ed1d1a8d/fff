//
//  NotYetSentRequestCell.swift
//  FF
//
//  Created by Stella Yang on 8/31/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit

class NotYetSentRequestCell: UITableViewCell {
    
    
    let container = FView(baseColor: UIColor.white)
    let nameLabel = FLabel(text: "",
                           font: UIFont.systemFont(ofSize: 18.0),
                           color: UIColor.black)
    let distLabel = FLabel(text: "",
                           font: UIFont.systemFont(ofSize: 14.0),
                           color: UIColor.black)
    
    let fakeProfPic = FImageView(name: "fakeProfPic",
                                 height: Dimensions.height * 0.055)
    
    init(data: EatRequestData) {
        super.init(style: .default, reuseIdentifier: "NotYetSentRequestCell")

        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.selectionStyle = .none
        
        let distance = data.distance * 1.6 / 1000
        
        self.backgroundColor = UIColor(red: 255.0/255.0, green: 245.0/255.0, blue: 225/255.0, alpha: 1)

        self.nameLabel.text = data.friendName
        self.distLabel.text = String(format: "%.2fm", distance)
        
        self.container.layer.cornerRadius = 10
        self.container.clipsToBounds = true
        
        self.container.addSubview(self.fakeProfPic)
        self.container.addSubview(self.nameLabel)
        self.container.addSubview(self.distLabel)
        self.contentView.addSubview(self.container)
        
        addConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addConstraints() {
                
        self.container.addConstraints(FConstraint.paddingPositionConstraints(view: self.fakeProfPic, sides: [.left], padding: 20))

        self.container.addConstraints(FConstraint.paddingPositionConstraints(view: self.fakeProfPic, sides: [.top], padding: 15))

        self.container.addConstraints(FConstraint.paddingPositionConstraints(view: self.nameLabel, sides: [.top], padding: 20))
        
        self.container.addConstraint(FConstraint.horizontalSpacingConstraint(leftView: self.fakeProfPic, rightView: self.nameLabel, spacing: 15))
        
        self.container.addConstraints(FConstraint.paddingPositionConstraints(view: self.nameLabel, sides: [.top], padding: 20))
        self.container.addConstraint(FConstraint.fillXConstraints(view: self.nameLabel, widthRatio: 0.8))
        
        
        self.container.addConstraint(FConstraint.verticalSpacingConstraint(upperView: self.nameLabel, lowerView: self.distLabel, spacing: 3))
        self.container.addConstraint(FConstraint.horizontalSpacingConstraint(leftView: self.fakeProfPic, rightView: self.distLabel, spacing: 15))

        self.container.addConstraints(FConstraint.paddingPositionConstraints(view: self.distLabel, sides: [.bottom], padding: 15))
    
        self.contentView.addConstraints(FConstraint.paddingPositionConstraints(view: self.container, sides: [.left, .right], padding: 45))
        self.contentView.addConstraint(FConstraint.paddingPositionConstraint(view: self.container, side: .top, padding: 15))
        self.contentView.addConstraint(FConstraint.paddingPositionConstraint(view: self.container, side: .bottom, padding: 15))
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        if (highlighted) {
            self.container.backgroundColor = self.container.darkerColor
        } else {
            self.container.backgroundColor = self.container.baseColor
        }
    }
    
}
