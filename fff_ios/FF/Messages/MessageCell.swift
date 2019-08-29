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
    let alternateOffset:CGFloat
    
    init(messageData: MessageData, messageType: MessageType, alternate: Bool) {
        self.messageType = messageType
        self.alternateOffset = alternate ? 15.0 : 0
        super.init(style: .default, reuseIdentifier: "incomingMessageCell")
        
        self.selectionStyle = .none
        
        messageBubble.text = messageData.message
        if (messageType == .Incoming) {
            self.messageBubble.textColor = Bubble.incomingTextColor
            self.messageBubble.layer.backgroundColor = Bubble.incomingColor.cgColor
        } else {
            self.messageBubble.textColor = Bubble.outgoingTextColor
            self.messageBubble.layer.backgroundColor = Bubble.outgoingColor.cgColor
        }
        
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
                                     y: alternateOffset,
                                     width: bubbleLength,
                                     height: bubbleHeight)
    }
    
}
