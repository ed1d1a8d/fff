//
//  MessagesViewController.swift
//  FF
//
//  Created by Jing Lin on 8/28/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit

class MessagesViewController: KeyboardViewController {
    
    let messagesTableView:MessagesTableView
    let keyboard:InputContainer = InputContainer()
    
    var messages:[MessageData]
    let senderID:String
    let recipientID:String
    
    init(senderID: String, recipientID: String, messages: [MessageData]) {
        self.senderID = senderID
        self.recipientID = recipientID
        self.messages = messages
        self.messagesTableView = MessagesTableView(messages: messages)
        super.init()
        
        self.keyboard.sendButton.addTarget(self, action: #selector(MessagesViewController.sendMessage), for: .touchUpInside)
    
        self.view.addSubview(self.messagesTableView)
        self.view.addSubview(self.keyboard)
        addConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addConstraints() {
        self.view.addConstraints(FConstraint.paddingPositionConstraints(view: self.messagesTableView, sides: [.left, .top, .right], padding: MessagesList.padding))
        self.view.addConstraint(FConstraint.verticalSpacingConstraint(upperView: self.messagesTableView, lowerView: self.keyboard, spacing: 0))

        self.keyboardConstraint = FConstraint.paddingPositionConstraint(view: self.keyboard, side: .bottom, padding: 0)
        self.view.addConstraint(self.keyboardConstraint)
        self.view.addConstraints(FConstraint.paddingPositionConstraints(view: self.keyboard, sides: [.left, .right], padding: 0))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
    }
}

extension MessagesViewController {
    
    @objc func sendMessage() {
        let message = self.keyboard.fetchText()
        if (message.count == 0) {
            return
        }
        
        let newMessage = MessageData(
            message: message,
            timestamp: NSDate(),
            senderName: self.senderID,
            receiverName: self.recipientID)
        self.messages.append(newMessage)
        self.messagesTableView.messages.append(newMessage)
        
        self.messagesTableView.reloadData()
        self.messagesTableView.layoutIfNeeded()
    }
    
}
