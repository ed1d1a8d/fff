//
//  FBLoginViewController.swift
//  FF
//
//  Created by Stella Yang on 8/29/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import SwiftUI
import FacebookLogin
import FBSDKLoginKit

class FBLoginViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let loginButton = FBLoginButton(permissions: [ .publicProfile, .email, .userFriends ])
        loginButton.center = view.center

        self.view.addSubview(loginButton)
        
        if let accessToken = AccessToken.current {
            print(AccessToken.current)
        }
    }
}

