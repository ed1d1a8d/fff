//
//  MessagesTableCell.swift
//  FF
//
//  Created by Jing Lin on 8/28/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit

enum MessageType {
    case Incoming
    case Outgoing
}

class MessageCell: UITableViewCell {
    
    let messageBubble = MessageBubble()
    let messageType:MessageType
    
    init(messageData: MessageData, messageType: MessageType) {
        self.messageType = messageType
        super.init(style: .default, reuseIdentifier: "incomingMessageCell")
        
        messageBubble.text = messageData.message
        messageBubble.layer.backgroundColor = UIColor.darkGray.cgColor
        
        self.backgroundColor = UIColor.green
        
        self.addSubview(messageBubble)
        setupElements()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupElements() {
        let bubbleLength = min(messageBubble.intrinsicContentSize.width, Bubble.bubbleLength)
        let bubbleHeight = heightForUILabel(text: messageBubble.text!, font: messageBubble.font, width: bubbleLength) + Bubble.vPadding * 2
        let offset = self.messageType == MessageType.Outgoing ? Bubble.offset - bubbleLength : 0
        
        messageBubble.frame = CGRect(x: offset,
                                     y: 0,
                                     width: bubbleLength,
                                     height: bubbleHeight)
    }
    
}
