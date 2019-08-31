//
//  EatRequestDelegate.swift
//  FF
//
//  Created by Jing Lin on 8/31/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

protocol EatRequestProtocol {

    func sendRequest(cell: NotYetSentRequestCell, message: String, eatRequestData: EatRequestData) 
    
}
