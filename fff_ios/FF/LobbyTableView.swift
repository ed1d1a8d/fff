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
    var notYetSentRequests:[EatRequestData] = []
    
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
                return notYetSentRequests.count
         }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath.section) {
            case 0:
                return IncomingRequestCell(data: self.incomingRequests[indexPath.row])
            case 1:
                return OutgoingRequestCell(data: self.outgoingRequests[indexPath.row])
            default:
                return NotYetSentRequestCell(data: self.notYetSentRequests[indexPath.row])
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
                    self.notYetSentRequests.append(request)
             }
        }
        
        self.incomingRequests = self.incomingRequests.sorted(by: { $0.distance < $1.distance })
        self.outgoingRequests = self.outgoingRequests.sorted(by: { $0.distance < $1.distance })
        self.notYetSentRequests = self.notYetSentRequests.sorted(by: { $0.distance < $1.distance })
        
        self.reloadData()
        self.layoutIfNeeded()
    }
    
}
