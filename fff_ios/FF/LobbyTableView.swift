//
//  FTableView.swift
//  FF
//
//  Created by Jing Lin on 8/27/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit

class LobbyTableView: UITableView, UITableViewDelegate {
    enum TableSection: Int {
      case incoming = 0, outgoing, notYetSent, total
    }
    
    // This is the size of our header sections that we will use later on.
    let SectionHeaderHeight: CGFloat = 25
    
    var lobbySource:[EatRequestData] = []
    
    var incomingRequests:[EatRequestData] = []
    var outgoingRequests:[EatRequestData] = []
    var notYetSentReqeusts:[EatRequestData] = []
    
    init() {
        super.init(frame: .zero, style: .plain)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.rowHeight = UITableView.automaticDimension
        self.estimatedRowHeight = 44.0
        
        self.dataSource = self
        self.delegate = self
        
        self.separatorColor = UIColor.clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension LobbyTableView: UITableViewDataSource {
    
    // As long as `total` is the last case in our TableSection enum,
    // this method will always be dynamically correct no mater how many table sections we add or remove.
    func numberOfSections(in tableView: UITableView) -> Int {
      return TableSection.total.rawValue
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch (section) {
            case 0:
                return incomingRequests.count
            case 1:
                return outgoingRequests.count
            default:
                return notYetSentReqeusts.count
         }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let data = self.lobbySource[indexPath.row]
//        let cell = LobbyCell(data: data)
//
//        return cell
//
//
        
        switch (indexPath.section) {
            case 0:
                return LobbyCell(data: self.incomingRequests[indexPath.row])
            case 1:
                return LobbyCell(data: self.outgoingRequests[indexPath.row])
            default:
                return LobbyCell(data: self.notYetSentReqeusts[indexPath.row])
         }
    }
    
    func updateData(data: [EatRequestData]) {
        self.lobbySource = data
        
        for request in data {
            switch (request.requestType) {
                case "incoming":
                    self.incomingRequests.append(request)
                case "outgoing":
                    self.outgoingRequests.append(request)
                default:
                    self.notYetSentReqeusts.append(request)
             }
        }
        
        self.reloadData()
        self.layoutIfNeeded()
    }
    
}
