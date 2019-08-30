//
//  FBLoginViewController.swift
//  FF
//
//  Created by Stella Yang on 8/29/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit
import SwiftUI
import FacebookLogin
import FBSDKLoginKit

class FBLoginViewController: UIViewController {
    
    let titleLabel = FLabel(text: "Let's Get Food",
                           font: UIFont.systemFont(ofSize: 32, weight: .medium),
                           color: UIColor.black)
    
    let p1 = FLabel(text: "Let’s Get Food helps you find friends who are down to eat.",
                           font: UIFont.systemFont(ofSize: 16, weight: .medium),
                           color: UIColor.black)
    
    let p2 = FLabel(text: "To get started, please register so we can sync your friends:",
                           font: UIFont.systemFont(ofSize: 16, weight: .medium),
                           color: UIColor.black)
    
    let container = FView(baseColor: UIColor.white)
    
    var fbLoginSuccess = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        // add title and text to the container
        self.container.addSubview(self.titleLabel)
        self.container.addSubview(self.p1)
        self.container.addSubview(self.p2)
        
        // add lobin button to the container
        let loginButton = FBLoginButton(permissions: [ .publicProfile, .email, .userFriends ])
        loginButton.delegate = self
        loginButton.center = view.center
        self.container.addSubview(loginButton)
        
        // add container to the subview
        self.view.addSubview(self.container)
        
        addConstraints()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        print(AccessToken.current)
//        if let accessToken = AccessToken.current {
//            print(AccessToken.current)
//            let nextViewController = SelectionViewController()
//            self.navigationController?.pushViewController(nextViewController, animated: true)
//        }
        
        if (AccessToken.current != nil && fbLoginSuccess == true)
        {
            print("Running 1")
            performSegue(withIdentifier: "loginSegue", sender: self)
        }
    }
    
    func loginButton(loginButton: FBLoginButton!, didCompleteWithResult result: LoginManagerLoginResult!, error: NSError!) {
        print("User Logged In")

        if ((error) != nil) {
            // Process error
            print(error)
        }
        else if result.isCancelled {
            // Handle cancellations
        }
        else {
            fbLoginSuccess = true
            // If you ask for multiple permissions at once, you
            // should check if specific permissions missing
            if result.grantedPermissions.contains("email") {
                // Do work
                print("HELLO WORLD")
            }
        }
    }
    
    func addConstraints() {
        self.container.addConstraints(FConstraint.paddingPositionConstraints(view: self.titleLabel, sides: [.left, .top, .right], padding: 20))
        
        self.container.addConstraint(FConstraint.verticalSpacingConstraint(upperView: self.titleLabel, lowerView: self.p1, spacing: 25))

        self.container.addConstraint(FConstraint.verticalSpacingConstraint(upperView: self.p1, lowerView: self.p2, spacing: 25))
        
        self.view.addConstraints(FConstraint.paddingPositionConstraints(view: self.container, sides: [.left, .top, .right], padding: 0))
        self.view.addConstraints(FConstraint.centerAlignConstraints(firstView: self.container, secondView: self.view))
    }
}

extension FBLoginViewController: LoginButtonDelegate {
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if let error = error {
            return
        }
        if (result!.isCancelled) {
            return
        }
        let nextViewController = SelectionViewController()
        self.navigationController?.pushViewController(nextViewController, animated: true)

    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
    }
    
    func loginButtonWillLogin(_ loginButton: FBLoginButton) -> Bool {
        return true
    }
    
}
