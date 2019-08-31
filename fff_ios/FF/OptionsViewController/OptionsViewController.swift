//
//  OptionsViewController.swift
//  FF
//
//  Created by Jing Lin on 8/30/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit
import CoreLocation

import FacebookLogin

class OptionsViewController: UIViewController {
    
    let optionsNavbar = OptionsNavbar()
    let menuOverview = OptionsDetailView()
    let darkView = OptionsDark()
    
    var xConstraint:NSLayoutConstraint!
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.menuOverview.optionsDelegate = self
        
        self.view.backgroundColor = Colors.background
        
//        LoginManager().logOut()
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(OptionsViewController.hideMenuOptions)))
        self.optionsNavbar.menu.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(OptionsViewController.showMenuOptions)))
        
        self.view.addSubview(self.optionsNavbar)
        self.view.addSubview(self.darkView)
        self.view.addSubview(self.menuOverview)
        addConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addConstraints() {
        self.view.addConstraints(FConstraint.paddingPositionConstraints(view: self.darkView, sides: [.top, .left, .bottom, .right], padding: 0))
        
        self.view.addConstraint(FConstraint.paddingPositionConstraint(view: self.optionsNavbar, side: .top, padding: 30))
        self.view.addConstraints(FConstraint.paddingPositionConstraints(view: self.optionsNavbar, sides: [.left, .right], padding: 0))
        
        self.view.addConstraint(FConstraint.paddingPositionConstraint(view: self.menuOverview, side: .top, padding: 0))
        
        self.xConstraint = NSLayoutConstraint(item: self.menuOverview, attribute: .left, relatedBy: .equal, toItem: self.view, attribute: .left, multiplier: 1.0, constant: -OptionsVC.dWidth)
        self.view.addConstraint(self.xConstraint)
    }
    
    @objc func showMenuOptions() {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
            self.xConstraint.constant = 0
            self.darkView.layer.opacity = 1.0
            self.view.layoutIfNeeded()
        }, completion: { completin in
            self.optionsNavbar.menu.backgroundColor = Colors.nav
        })
    }
    
    func _hideMenuAnimations(detailType: String) {
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveEaseIn, animations: {
            self.xConstraint.constant = -OptionsVC.dWidth
            self.darkView.layer.opacity = 0.0
            self.view.layoutIfNeeded()
        }, completion: { completion in
            if (self.menuOverview.clickedDetail == nil || detailType == "") {
                return
            }
            
            var viewController:UIViewController!
            if detailType == "Lobby" {
                let lobbyViewController = LobbyViewController()
                viewController = FFNavigationController(rootViewController: lobbyViewController)
                
                for friend in Fake.Friends.one {
                    let friendLocation = CLLocation(latitude: friend.friendLat, longitude: friend.friendLng)
                    let distance = Fake.Friends.currLocation.distance(from: friendLocation)
                    friend.distance = distance
                }
                lobbyViewController.updateLobbySource(data: Fake.Friends.one)
            }
            self.menuOverview.clickedDetail = nil
            
            self.present(viewController, animated: true, completion: nil)
        })
    }
    
    @objc func hideMenuOptions(recognizer: UITapGestureRecognizer) {
        let location = recognizer.location(in: recognizer.view)
        if recognizer.view!.hitTest(location, with: nil) == self.menuOverview {
            return
        }
        
        _hideMenuAnimations(detailType: "")
    }
    
}

extension OptionsViewController: OptionsShowVCDelegate {
    
    func showVC(detailType: String) {
        _hideMenuAnimations(detailType: detailType)
    }
    
}
