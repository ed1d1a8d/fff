//
//  MessagesTableView.swift
//  FF
//
//  Created by Jing Lin on 8/28/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit

class MessagesTableView: UITableView {
    
    var messages:[MessageData]
    
    init(messages: [MessageData]) {
        self.messages = messages
        
        super.init(frame: .zero, style: .plain)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.separatorStyle = .none
        
        self.contentInset = .zero
        
        self.dataSource = self
        self.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MessagesTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let messageData = self.messages[indexPath.row]
        let messageType = messageData.senderName == "Jing Lin" ? MessageType.Outgoing : MessageType.Incoming
        
        let priorData = self.messages[max(0, indexPath.row - 1)]
        let alternate = !(messageData.receiverName == priorData.receiverName)
        
        return MessageCell(messageData: messageData, messageType: messageType, alternate: alternate)
    }
    
}

extension MessagesTableView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let priorData = self.messages[max(0, indexPath.row - 1)]
        let messageData = self.messages[indexPath.row]

        let alternate = !(messageData.receiverName == priorData.receiverName)
        let alternateOffset:CGFloat = alternate ? 15 : 0
        
        return heightForUILabel(text: self.messages[indexPath.row].message, font: Bubble.font, width: Bubble.bubbleLength) +
            Bubble.vPadding * 2 +
            Bubble.cushion +
            alternateOffset
    }
    
}
