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
        view.backgroundColor = UIColor(red: 253.0/255.0, green: 240.0/255.0, blue: 196.0/255.0, alpha: 1)
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
                return IncomingRequestCell(data: self.incomingRequests[indexPath.row])
            case 1:
                let cell = OutgoingRequestCell(data: self.outgoingRequests[indexPath.row])
                cell.blackX.tag = indexPath.row
                cell.blackX.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(LobbyTableView.deleteRequest)))
                return cell
            default:
                return NotYetSentRequestCell(data: self.notYetSentRequests[indexPath.row])
         }
    }
    
    @objc func deleteRequest() {
        
    }
    
}
