//
//  Fake.swift
//  FF
//
//  Created by Jing Lin on 8/28/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit

struct Fake {
    
    struct Conversations {
        static let one:[MessageData] = [
            MessageData(message: "Hey, it's been a while since we've met up. sdlfkj dslf jdsklf jdlksf jlsdkjf lsj fklsfj slfj",
                        timestamp: NSDate(timeIntervalSince1970: 100),
                        senderName: "Jing Lin",
                        receiverName: "Corrine Li"),
            MessageData(message: "Do you want to have dinner at some point?",
                        timestamp: NSDate(timeIntervalSince1970: 110),
                        senderName: "Jing Lin",
                        receiverName: "Corrine Li"),
            MessageData(message: "I would love to.",
                        timestamp: NSDate(timeIntervalSince1970: 120),
                        senderName: "Corrine Li",
                        receiverName: "Jing Lin"),
            MessageData(message: "Pho?",
                        timestamp: NSDate(timeIntervalSince1970: 130),
                        senderName: "Corrine Li",
                        receiverName: "Jing Lin"),
            
            ]
    }
}
