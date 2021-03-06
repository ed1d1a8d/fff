//
//  Fake.swift
//  FF
//
//  Created by Jing Lin on 8/28/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit
import CoreLocation

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
    
    struct Friends {
        static let one:[FriendData] = [
            FriendData(friendName: "Tony Wang",
                       friendID: "twang",
                       friendLat: 42.3621,
                       friendLng: -71.0962),
            FriendData(friendName: "Stella Yang",
                       friendID: "syang",
                       friendLat: 42.3631,
                       friendLng: -71.0982),
            FriendData(friendName: "Gilbert Yan",
                       friendID: "gyan",
                       friendLat: 42.3581,
                       friendLng: -71.0962),
        ]
        static let currLocation = CLLocation(latitude: 42.3591, longitude: -71.0967)
    }
    
    struct EatRequests {
        static let one:[EatRequestData] = [
            EatRequestData(friendName: "Stella Yang",
                       friendID: "syang",
                       friendLat: 42.3621,
                       friendLng: -71.0962,
                       message: "Let's get ramen",
                       requestType: "incoming"),
            EatRequestData(friendName: "Edward Park",
                       friendID: "parke",
                       friendLat: 42.3641,
                       friendLng: -71.0982,
                       message: "Chinese food truck?",
                       requestType: "incoming"),
            EatRequestData(friendName: "Tony Wang",
                       friendID: "twang",
                       friendLat: 42.3631,
                       friendLng: -71.0982,
                       message: "Yo wanna get food",
                       requestType: "outgoing"),
            EatRequestData(friendName: "Gilbert Yan",
                       friendID: "gyan",
                       friendLat: 42.3581,
                       friendLng: -71.0962,
                       message: "",
                       requestType: "notYetSent"),
            EatRequestData(friendName: "Jing Lin",
                       friendID: "jlin",
                       friendLat: 42.3589,
                       friendLng: -71.0964,
                       message: "",
                       requestType: "notYetSent"),
            EatRequestData(friendName: "Claire Yang",
                       friendID: "cty",
                       friendLat: 42.3573,
                       friendLng: -71.0973,
                       message: "",
                       requestType: "notYetSent"),
        ]
        static let currLocation = CLLocation(latitude: 42.3591, longitude: -71.0967)
    }
    
}
