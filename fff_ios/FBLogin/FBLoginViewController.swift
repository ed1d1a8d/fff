//
//  FBLoginViewController.swift
//  FF
//
//  Created by Stella Yang on 8/29/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit
import FacebookLogin
import FBSDKLoginKit
import FBSDKCoreKit

class FBLoginViewController: UIViewController {
    
    let titleLabel = FLabel(text: "Free\nFor\nFood?",
                           font: UIFont.systemFont(ofSize: 56, weight: .regular),
                           color: UIColor.black)
    let descLabel = FLabel(text: "Find friends who\nwant to eat right now",
                           font: UIFont.systemFont(ofSize: 20, weight: .regular),
                           color: UIColor.black)
    
    let loginManager = LoginManager()
    let fbButton = FBButton()
    let otherRegButton = OtherRegButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = Colors.background
        
        self.descLabel.textAlignment = .center
        self.fbButton.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(FBLoginViewController.fetchFacebookUserInfo)))
        
        self.view.addSubview(self.titleLabel)
        self.view.addSubview(self.descLabel)
        self.view.addSubview(self.fbButton)
        self.view.addSubview(self.otherRegButton)
        
        addConstraints()
    }
    
    func addConstraints() {
        self.view.addConstraints(FConstraint.paddingPositionConstraints(view: self.titleLabel, sides: [.left, .top], padding: 40))
        self.view.addConstraints(FConstraint.centerAlignConstraints(firstView: self.descLabel, secondView: self.view))
        
        self.view.addConstraints(FConstraint.paddingPositionConstraints(view: self.fbButton, sides: [.left, .right], padding: 40))
        self.view.addConstraint(FConstraint.verticalSpacingConstraint(upperView: self.fbButton, lowerView: self.otherRegButton, spacing: 20))
        self.view.addConstraints(FConstraint.paddingPositionConstraints(view: self.otherRegButton, sides: [.left, .bottom, .right], padding: 40))
    }
    
    @objc func fetchFacebookUserInfo() {
        self.loginManager.logIn(permissions: [.email, .userFriends], viewController: self) { (result) in
            switch result {
            case .cancelled:
                print("Cancelled")
                self.fbButton.backgroundColor = Colors.fb
            case .success:
                let params = ["fields": "id, name, picture.type(small), email"]
                let graphRequest = GraphRequest(graphPath: "/me", parameters: params)
                let connection = GraphRequestConnection()
                connection.add(graphRequest, completionHandler: { (connection, result, error) in
                    let info = result as! [String: AnyObject]
                    print(info)
                    let selectionViewController = SelectionViewController()
                    self.present(selectionViewController, animated: true, completion: nil)
                })
                connection.start()
            default:
                print("Nothing")
                self.fbButton.backgroundColor = Colors.fb
            }
        }
    }
    
}

extension FBLoginViewController: LoginButtonDelegate {
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if error != nil  || result!.isCancelled {
            return
        }
        let selectionViewController = SelectionViewController()
        self.present(selectionViewController, animated: true, completion: nil)

    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        
    }
    
    func loginButtonWillLogin(_ loginButton: FBLoginButton) -> Bool {
        return true
    }
    
}
