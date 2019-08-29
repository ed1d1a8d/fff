//
//  LobbyViewController.swift
//  FF
//
//  Created by Jing Lin on 8/27/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit

class LobbyViewController: UIViewController {
    
    let lobbyLabel = FLabel(text: "The Lobby",
                            font: UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.medium),
                            color: UIColor.black)
    let lobbyTableView = LobbyTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(LobbyViewController.dismissSelf))
        self.navigationItem.rightBarButtonItem = cancelButton
    
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.shadowImage = UIImage() //remove pesky 1 pixel line
        
        self.lobbyTableView.delegate = self
        
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(self.lobbyLabel)
        self.view.addSubview(self.lobbyTableView)
        addConstraints()
    }
    
    func addConstraints() {
        self.view.addConstraints(FConstraint.paddingPositionConstraints(view: self.lobbyLabel, sides: [.left, .right], padding: 35))
        self.view.addConstraint(FConstraint.paddingPositionConstraint(view: self.lobbyLabel, side: .top, padding: 0))
        
        self.view.addConstraints(FConstraint.paddingPositionConstraints(view: self.lobbyTableView, sides: [.left, .right ,.bottom], padding: 0))
        self.view.addConstraint(FConstraint.verticalSpacingConstraint(upperView: self.lobbyLabel, lowerView: self.lobbyTableView, spacing: 20))
    }
    
    func updateLobbySource(data: [String]) {
        self.lobbyTableView.updateData(data: data)
    }
    
    @objc func dismissSelf() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension LobbyViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let messagesViewController = MessagesViewController(senderID: "Jing Lin", recipientID: "Corrine Li", messages: Fake.Conversations.one)
        let title = (lobbyTableView.cellForRow(at: indexPath) as! LobbyCell).nameLabel.text!
            
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: nil, action: nil)
        self.navigationController?.pushViewController(messagesViewController, animated: true)
    }
    
}
