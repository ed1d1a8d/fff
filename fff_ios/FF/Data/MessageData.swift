//
//  MessageData.swift
//  FF
//
//  Created by Jing Lin on 8/28/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit

class MessageData: NSObject {
    
    let message:String
    let timestamp:NSDate
    let senderName:String
    let receiverName:String
    
    init(message: String, timestamp: NSDate, senderName: String, receiverName: String) {
        self.message = message
        self.timestamp = timestamp
        self.senderName = senderName
        self.receiverName = receiverName
    }
    
}
