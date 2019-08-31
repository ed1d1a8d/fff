//
//  UserData.swift
//  FF
//
//  Created by Jing Lin on 8/31/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

class UserData {
    
    static let shared = UserData()
    var fbAuth:Bool = false
    
    private init() { }
    
}
