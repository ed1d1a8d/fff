//
//  FindFriendsViewController.swift
//
//
//  Created by Stella Yang on 8/30/19.
//

import UIKit

class FindFriendsViewController: UIViewController {
    
    let friendData:[FriendData]
    
    let topBannerContainer = FView(baseColor: UIColor(red: 253.0/255.0, green: 240.0/255.0, blue: 196.0/255.0, alpha: 1))
        
    let searchPeopleLabel = FLabel(text: "Friends List",
                           font: UIFont.systemFont(ofSize: 30, weight: .medium),
                           color: UIColor.black)
    
    let friendsIcon = FImageView(name: "friendsIcon",
                             height: Dimensions.height * 0.1)
    
    let bottomContainer = FView(baseColor: UIColor.white)
    
    let friendsLabel = FLabel(text: "Friends",
                           font: UIFont.systemFont(ofSize: 18, weight: .medium),
                           color: UIColor.black)
    
    let friendsTableView = FriendsTableView()
        
    init(friendData: [FriendData]) {
        self.friendData = friendData
        
        friendsTableView.updateData(data: friendData)
        
        super.init(nibName: nil, bundle: nil)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(FindFriendsViewController.dismissSelf))
        self.navigationItem.rightBarButtonItem = cancelButton

        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = Colors.background
        self.navigationController?.navigationBar.shadowImage = UIImage() //remove pesky 1 pixel line
        
        self.topBannerContainer.addSubview(self.friendsIcon)
        self.topBannerContainer.addSubview(self.searchPeopleLabel)

        self.view.addSubview(self.topBannerContainer)
            
        self.bottomContainer.addSubview(self.friendsLabel)
        self.bottomContainer.addSubview(self.friendsTableView)

        self.view.addSubview(self.bottomContainer)
        
        
        addConstraints()
    }
    
    func addConstraints() {
        
        // Top Banner Placement & Sizing
        self.view.addConstraints(FConstraint.paddingPositionConstraints(view: self.topBannerContainer, sides: [.left, .top, .right], padding: 0))

        self.view.addConstraint(FConstraint.fillYConstraints(view: self.topBannerContainer, heightRatio: 0.25))
  
        // Friends Icon positioning
        self.topBannerContainer.addConstraint(FConstraint.equalConstraint(firstView: self.friendsIcon, secondView: self.topBannerContainer, attribute: .centerX))
        
        self.topBannerContainer.addConstraints(FConstraint.paddingPositionConstraints(view: self.friendsIcon, sides: [.top], padding: 65))

        // Title Text Positioning
        self.topBannerContainer.addConstraint(FConstraint.verticalSpacingConstraint(upperView: self.friendsIcon, lowerView: self.searchPeopleLabel, spacing: 15))
        
        self.topBannerContainer.addConstraint(FConstraint.equalConstraint(firstView: self.searchPeopleLabel, secondView: self.topBannerContainer, attribute: .centerX))
                
        // Bottom Banner Placement
        self.view.addConstraints(FConstraint.paddingPositionConstraints(view: self.bottomContainer, sides: [.left, .bottom, .right], padding: 0))
        
        self.view.addConstraint(FConstraint.verticalSpacingConstraint(upperView: self.topBannerContainer, lowerView: self.bottomContainer, spacing: 0))
    
        // Friends label placement
        self.bottomContainer.addConstraints(FConstraint.paddingPositionConstraints(view: self.friendsLabel, sides: [.left, .top], padding: 10))

        // Friends Table Placement
        self.bottomContainer.addConstraint(FConstraint.verticalSpacingConstraint(upperView: self.friendsLabel, lowerView: self.friendsTableView, spacing: 10))
        self.bottomContainer.addConstraints(FConstraint.paddingPositionConstraints(view: self.friendsTableView, sides: [.left, .bottom, .right], padding: 0))
        
    }
    
    func updateFriendsSource(data: [FriendData]) {
        self.friendsTableView.updateData(data: data)
    }
    
    @objc func dismissSelf() {
        self.dismiss(animated: true, completion: nil)
    }
    
}
