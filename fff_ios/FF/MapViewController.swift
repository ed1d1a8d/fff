//
//  MapViewController.swift
//  FF
//
//  Created by Jing Lin on 8/27/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit

class MapViewController: UIViewController {

    let friendButton = FButton(titleText: "5 friends nearby")
    let lobbyViewController = UINavigationController(rootViewController: LobbyViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor.orange
        
        self.friendButton.addTarget(self, action: #selector(MapViewController.friendClick), for: .touchDown)
        
        self.view.addSubview(self.friendButton)
        
        addConstraints()
    }
    
    func addConstraints() {
        self.view.addConstraints(FConstraint.paddingPositionConstraints(view: self.friendButton, sides: [.left, .right], padding: 40))
        self.view.addConstraint(FConstraint.paddingPositionConstraint(view: self.friendButton, side: .bottom, padding: 40))
        self.view.addConstraint(FConstraint.fillYConstraints(view: self.friendButton, heightRatio: 0.07))
    }

    @objc func friendClick() {
        let lobbyFunctions = lobbyViewController.topViewController as! LobbyViewController
        
        let data = [
            "Stella Yang,0.1", "Gilbert Yan,0.2", "Tony Wang,0.3",
            "Stella Yang,0.1", "Gilbert Yan,0.2", "Tony Wang,0.3",
            "Stella Yang,0.1", "Gilbert Yan,0.2", "Tony Wang,0.3",
            "Stella Yang,0.1", "Gilbert Yan,0.2", "Tony Wang,0.3"
        ]
        
        lobbyFunctions.updateLobbySource(data: data)
        self.present(lobbyViewController, animated: true, completion: nil)
    }
}

