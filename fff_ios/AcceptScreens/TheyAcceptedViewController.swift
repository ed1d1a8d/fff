//
//  TheyAcceptedViewController.swift
//  FF
//
//  Created by Stella Yang on 8/31/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//


import UIKit

class TheyAcceptedViewController: UIViewController {
    
    let eatRequestData:EatRequestData
    
    let topBannerContainer = FView(baseColor: UIColor.white)
        
    let successLabel = FLabel(text: "Success!",
                           font: UIFont.systemFont(ofSize: 30, weight: .medium),
                           color: UIColor.black)

    let bottomContainer = FView(baseColor: UIColor(red: 253.0/255.0, green: 240.0/255.0, blue: 196.0/255.0, alpha: 1))
    
    let friendsLabel:FLabel
    
    let container = FView(baseColor: UIColor.white)

    let nameLabel = FLabel(text: "",
                           font: UIFont.systemFont(ofSize: 18.0),
                           color: UIColor.black)
    let distLabel = FLabel(text: "",
                           font: UIFont.systemFont(ofSize: 14.0),
                           color: UIColor.black)
    
    let messageLabel = FLabel(text: "",
                           font: UIFont.systemFont(ofSize: 14.0),
                           color: UIColor.black)
    
    let fakeProfPic = FImageView(name: "fakeProfPic",
                                 height: Dimensions.height * 0.055)
    
    let happyLabel = FLabel(text: "Have a good meal!",
                           font: UIFont.systemFont(ofSize: 24, weight: .medium),
                           color: UIColor.black)
    
    let fffIcon = FImageView(name: "fffIcon",
                             height: Dimensions.height * 0.1)
    
    let againButton = FButton(titleText: "Find Another Friend")
    
    let selectionViewController = FFNavigationController(rootViewController: SelectionViewController())

    init(eatRequestInfo: EatRequestData) {
        self.eatRequestData = eatRequestInfo
                
        self.friendsLabel = FLabel(text: "\(self.eatRequestData.friendName) just accepted your request:",
                            font: UIFont.systemFont(ofSize: 18, weight: .medium),
                            color: UIColor.black)
        super.init(nibName: nil, bundle: nil)
        
        self.nameLabel.text = self.eatRequestData.friendName
        let distance = self.eatRequestData.distance * 1.6 / 1000
        self.distLabel.text = String(format: "%.2fm", distance)

        self.messageLabel.text = self.eatRequestData.message
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.againButton.addTarget(self, action: #selector(TheyAcceptedViewController.againClick), for: .touchUpInside)

        self.view.backgroundColor = UIColor.white
        
        self.topBannerContainer.addSubview(self.successLabel)

        self.view.addSubview(self.topBannerContainer)
            
        self.bottomContainer.addSubview(self.friendsLabel)
        
        self.container.addSubview(self.fakeProfPic)
        self.container.addSubview(self.nameLabel)
        self.container.addSubview(self.distLabel)
        self.container.addSubview(self.messageLabel)
        self.bottomContainer.addSubview(self.container)
        
        self.bottomContainer.addSubview(self.happyLabel)
        self.bottomContainer.addSubview(self.fffIcon)
        self.bottomContainer.addSubview(self.againButton)
        
        self.view.addSubview(self.bottomContainer)
        
        addConstraints()
    }
    
    @objc func againClick() {
        self.present(selectionViewController, animated: true, completion: nil)
    }
    
    func addConstraints() {
        
        // Top Banner Placement & Sizing
        self.view.addConstraints(FConstraint.paddingPositionConstraints(view: self.topBannerContainer, sides: [.left, .top, .right], padding: 0))

        self.view.addConstraint(FConstraint.fillYConstraints(view: self.topBannerContainer, heightRatio: 0.15))
        
        self.topBannerContainer.addConstraints(FConstraint.paddingPositionConstraints(view: self.successLabel, sides: [.top], padding: 75))

        self.topBannerContainer.addConstraint(FConstraint.equalConstraint(firstView: self.successLabel, secondView: self.topBannerContainer, attribute: .centerX))

        // Bottom Banner Placement
        self.view.addConstraints(FConstraint.paddingPositionConstraints(view: self.bottomContainer, sides: [.left, .bottom, .right], padding: 0))
        
        self.view.addConstraint(FConstraint.verticalSpacingConstraint(upperView: self.topBannerContainer, lowerView: self.bottomContainer, spacing: 0))
    
        // Friends label placement
        self.bottomContainer.addConstraints(FConstraint.paddingPositionConstraints(view: self.friendsLabel, sides: [.top], padding: 40))
        
        self.bottomContainer.addConstraint(FConstraint.equalConstraint(firstView: self.friendsLabel, secondView: self.bottomContainer, attribute: .centerX))
        
        // Container cell specs
               
       self.container.addConstraints(FConstraint.paddingPositionConstraints(view: self.fakeProfPic, sides: [.left], padding: 20))
       
       self.container.addConstraints(FConstraint.paddingPositionConstraints(view: self.nameLabel, sides: [.top], padding: 20))
       
       self.container.addConstraint(FConstraint.horizontalSpacingConstraint(leftView: self.fakeProfPic, rightView: self.nameLabel, spacing: 15))
       
       self.container.addConstraint(FConstraint.verticalSpacingConstraint(upperView: self.fakeProfPic, lowerView: self.messageLabel, spacing: 10))
       
       self.container.addConstraints(FConstraint.paddingPositionConstraints(view: self.nameLabel, sides: [.top], padding: 20))
        
       self.container.addConstraint(FConstraint.fillXConstraints(view: self.nameLabel, widthRatio: 0.8))
       
       self.container.addConstraint(FConstraint.verticalSpacingConstraint(upperView: self.nameLabel, lowerView: self.distLabel, spacing: 3))
        
       self.container.addConstraint(FConstraint.horizontalSpacingConstraint(leftView: self.fakeProfPic, rightView: self.distLabel, spacing: 15))
       
       self.container.addConstraint(FConstraint.verticalSpacingConstraint(upperView: self.distLabel, lowerView: self.messageLabel, spacing: 10))

       self.container.addConstraints(FConstraint.paddingPositionConstraints(view: self.messageLabel, sides: [.left], padding: 15))

       self.container.addConstraints(FConstraint.paddingPositionConstraints(view: self.messageLabel, sides: [.bottom], padding: 15))
        
        self.bottomContainer.addConstraints(FConstraint.paddingPositionConstraints(view: self.container, sides: [.left, .right], padding: 45))
        self.bottomContainer.addConstraint(FConstraint.paddingPositionConstraint(view: self.container, side: .top, padding: 95))
        self.bottomContainer.addConstraint(FConstraint.fillYConstraints(view: self.container, heightRatio: 0.15))

        // Happy Label Positioning
        self.bottomContainer.addConstraint(FConstraint.verticalSpacingConstraint(upperView: self.container, lowerView: self.happyLabel, spacing: 70))
                
        self.bottomContainer.addConstraint(FConstraint.equalConstraint(firstView: self.happyLabel, secondView: self.bottomContainer, attribute: .centerX))

        // FFF Icon Positioning
        self.bottomContainer.addConstraint(FConstraint.verticalSpacingConstraint(upperView: self.happyLabel, lowerView: self.fffIcon, spacing: 70))
        
        self.bottomContainer.addConstraint(FConstraint.equalConstraint(firstView: self.fffIcon, secondView: self.bottomContainer, attribute: .centerX))
        
        // Again Button Positioning
        self.bottomContainer.addConstraint(FConstraint.verticalSpacingConstraint(upperView: self.fffIcon, lowerView: self.againButton, spacing: 70))
        
        self.bottomContainer.addConstraint(FConstraint.equalConstraint(firstView: self.againButton, secondView: self.bottomContainer, attribute: .centerX))
        
        // Again Button styling
        self.bottomContainer.addConstraints(FConstraint.paddingPositionConstraints(view: self.againButton, sides: [.left, .right], padding: 45))
        
    }
    
}
