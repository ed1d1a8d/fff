//
//  FriendData.swift
//  FF
//
//  Created by Jing Lin on 8/29/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit

class FriendData: NSObject {
    
    let friendName:String
    let friendID:String
    let friendLat:Double
    let friendLng:Double
    
    init(friendName: String, friendID: String, friendLat: Double, friendLng: Double) {
        self.friendName = friendName
        self.friendID = friendID
        self.friendLat = friendLat
        self.friendLng = friendLng
    }
    
}
