//
//  EatRequestData.swift
//  FF
//
//  Created by Stella Yang on 8/31/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit

class EatRequestData: NSObject {
    
    let friendName:String
    let friendID:String
    var distance:Double
    var friendLat:Double
    var friendLng:Double
    
    // This can either be the message they sent you, or the message you sent them. It is empty for requests that haven't been sent yet
    var message:String

    var requestType:String //This can be "incoming" "outgoing" or "notYetSent"
    
    init(friendName: String, friendID: String, friendLat:Double, friendLng:Double, message: String, requestType: String) {
        self.friendName = friendName
        self.friendID = friendID
        self.friendLat = friendLat
        self.friendLng = friendLng
        self.distance = 0
        self.message = message
        self.requestType = requestType
    }
    
}
