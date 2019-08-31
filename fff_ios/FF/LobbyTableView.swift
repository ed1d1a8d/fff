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
    
    var incomingDelegate:IncomingEatRequestProtocol!
    
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
    
    func updateData(data: [EatRequestData], incomingEatRequestDelegate: IncomingEatRequestProtocol) {
        self.lobbySource = data
        self.incomingDelegate = incomingEatRequestDelegate
        
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

extension LobbyTableView: UITableViewDataSource {
    
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
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.width, height: SectionHeaderHeight))
        view.backgroundColor = UIColor(red: 255.0/255.0, green: 245.0/255.0, blue: 225/255.0, alpha: 1)
        let label = UILabel(frame: CGRect(x: 15, y: 0, width: tableView.bounds.width - 30, height: SectionHeaderHeight))
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textColor = UIColor.black
        if let tableSection = TableSection(rawValue: section) {
            switch tableSection {
            case .incoming:
                label.text = "Incoming Requests"
            case .outgoing:
                label.text = "Sent Requests"
            case .notYetSent:
                label.text = "Friends"
            default:
                label.text = ""
            }
        }
        view.addSubview(label)
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch (indexPath.section) {
            case 0:
                let cell = IncomingRequestCell(data: self.incomingRequests[indexPath.row])
                cell.incomingDelegate = self.incomingDelegate
                return cell
            case 1:
                return OutgoingRequestCell(data: self.outgoingRequests[indexPath.row])
            default:
                let cell = NotYetSentRequestCell(data: self.notYetSentRequests[indexPath.row])
                cell.requestDataDelegate = self
                return cell
         }
    }
}

extension LobbyTableView: EatRequestProtocol {
    
    func sendRequest(cell: NotYetSentRequestCell, message: String, eatRequestData: EatRequestData) {
        self.notYetSentRequests.removeAll{$0 == eatRequestData}
        
        eatRequestData.message = message
        self.outgoingRequests.append(eatRequestData)
        
        self.reloadData()
        // TODO: TONY GILBERT SET TO OUTGOING
    }
    
}
