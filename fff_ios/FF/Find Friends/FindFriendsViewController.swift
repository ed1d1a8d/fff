//
//  FindFriendsViewController.swift
//
//
//  Created by Stella Yang on 8/30/19.
//

import UIKit

class FindFriendsViewController: UIViewController {
    
    let topBannerContainer = FView(baseColor: UIColor.white)
    
    let searchPeopleLabel = FLabel(text: "Search People",
                           font: UIFont.systemFont(ofSize: 30, weight: .medium),
                           color: UIColor.black)
    
    let searchBarUI = UISearchBar.init()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.orange
        
    self.topBannerContainer.addSubview(self.searchPeopleLabel)
    self.topBannerContainer.addSubview(self.searchBarUI)
    
    self.view.addSubview(self.topBannerContainer)
        
        addConstraints()
    }
    
    func addConstraints() {
    self.view.addConstraints(FConstraint.paddingPositionConstraints(view: self.topBannerContainer, sides: [.left, .top, .right], padding: 0))

    self.view.addConstraint(FConstraint.fillYConstraints(view: self.topBannerContainer, heightRatio: 0.3))
        
    self.view.addConstraints(FConstraint.centerAlignConstraints(firstView: self.topBannerContainer, secondView: self.searchPeopleLabel))
        
//    self.topBannerContainer.addConstraint(FConstraint.verticalSpacingConstraint(upperView: self.searchPeopleLabel, lowerView: self.searchBarUI, spacing: 25))
    }
    
    
    
}
