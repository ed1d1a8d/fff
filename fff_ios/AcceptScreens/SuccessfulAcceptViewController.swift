//
//  SuccessfulAcceptViewController.swift
//
//
//  Created by Stella Yang on 8/30/19.
//

import UIKit

class SuccessfulAcceptViewController: UIViewController {
    
    let eatRequestData:EatRequestData
    
    let topBannerContainer = FView(baseColor: UIColor.white)
        
    let successLabel = FLabel(text: "Success!",
                           font: UIFont.systemFont(ofSize: 30, weight: .medium),
                           color: UIColor.black)

    let bottomContainer = FView(baseColor: UIColor(red: 253.0/255.0, green: 240.0/255.0, blue: 196.0/255.0, alpha: 1))
    
    let friendsLabel = FLabel(text: "You successfully accepted this request:",
                           font: UIFont.systemFont(ofSize: 18, weight: .medium),
                           color: UIColor.black)
    
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
    
    let blackX = FImageView(name: "blackX",
                                 height: Dimensions.height * 0.022)
    
    init(eatRequestInfo: EatRequestData) {
        self.eatRequestData = eatRequestInfo
                
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
        
        self.view.backgroundColor = UIColor.white
        
        self.topBannerContainer.addSubview(self.successLabel)

        self.view.addSubview(self.topBannerContainer)
            
        self.bottomContainer.addSubview(self.friendsLabel)
        
        self.container.addSubview(self.fakeProfPic)
        self.container.addSubview(self.blackX)
        self.container.addSubview(self.nameLabel)
        self.container.addSubview(self.distLabel)
        self.container.addSubview(self.messageLabel)
        self.bottomContainer.addSubview(self.container)

        self.view.addSubview(self.bottomContainer)
        
        
        addConstraints()
    }
    
    func addConstraints() {
        
        // Top Banner Placement & Sizing
        self.view.addConstraints(FConstraint.paddingPositionConstraints(view: self.topBannerContainer, sides: [.left, .top, .right], padding: 0))

        self.view.addConstraint(FConstraint.fillYConstraints(view: self.topBannerContainer, heightRatio: 0.15))
        
        self.topBannerContainer.addConstraints(FConstraint.paddingPositionConstraints(view: self.successLabel, sides: [.top], padding: 75))

        self.topBannerContainer.addConstraints(FConstraint.paddingPositionConstraints(view: self.successLabel, sides: [.left], padding: 40))

        // Bottom Banner Placement
        self.view.addConstraints(FConstraint.paddingPositionConstraints(view: self.bottomContainer, sides: [.left, .bottom, .right], padding: 0))
        
        self.view.addConstraint(FConstraint.verticalSpacingConstraint(upperView: self.topBannerContainer, lowerView: self.bottomContainer, spacing: 0))
    
        // Friends label placement
        self.bottomContainer.addConstraints(FConstraint.paddingPositionConstraints(view: self.friendsLabel, sides: [.left, .top, .right], padding: 40))
        
        // Container cell specs
        
       self.container.addConstraints(FConstraint.paddingPositionConstraints(view: self.blackX, sides: [.right, .top], padding: 20))
       
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

    }
    
}
