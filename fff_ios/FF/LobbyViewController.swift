//
//  LobbyViewController.swift
//  FF
//
//  Created by Jing Lin on 8/27/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit

class LobbyViewController: UIViewController {
    
    enum TableSection: Int {
      case incoming = 0, outgoing, notYetSent, total
    }
    
    // Size of  header sections
    let SectionHeaderHeight: CGFloat = 25
    
    
    let lobbyLabel = FLabel(text: "The Lobby",
                            font: UIFont.systemFont(ofSize: 24, weight: UIFont.Weight.medium),
                            color: UIColor.black)
    let lobbyTableView = LobbyTableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .stop, target: self, action: #selector(LobbyViewController.dismissSelf))
        self.navigationItem.rightBarButtonItem = cancelButton
    
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.shadowImage = UIImage() //remove pesky 1 pixel line
        
        self.lobbyTableView.delegate = self
        
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(self.lobbyLabel)
        self.view.addSubview(self.lobbyTableView)
        addConstraints()
    }
    
    func addConstraints() {
        self.view.addConstraints(FConstraint.paddingPositionConstraints(view: self.lobbyLabel, sides: [.left, .right], padding: 35))
        self.view.addConstraint(FConstraint.paddingPositionConstraint(view: self.lobbyLabel, side: .top, padding: 0))
        
        self.view.addConstraints(FConstraint.paddingPositionConstraints(view: self.lobbyTableView, sides: [.left, .right ,.bottom], padding: 0))
        self.view.addConstraint(FConstraint.verticalSpacingConstraint(upperView: self.lobbyLabel, lowerView: self.lobbyTableView, spacing: 20))
    }
    
    func updateLobbySource(data: [EatRequestData]) {
        self.lobbyTableView.updateData(data: data)
    }
    
    @objc func dismissSelf() {
        self.dismiss(animated: true, completion: nil)
    }
}

extension LobbyViewController: UITableViewDelegate {
    
     func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
          // If we wanted to always show a section header regardless of whether or not there were rows in it,
          // then uncomment this line below:
          return SectionHeaderHeight

    //      // First check if there is a valid section of table.
    //      // Then we check that for the section there is more than 1 row.
    //      if let tableSection = TableSection(rawValue: section), let lobbySource = data[tableSection], lobbySource.count > 0 {
    //        return SectionHeaderHeight
    //      }
    //      return 0
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
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let messagesViewController = MessagesViewController(senderID: "Jing Lin", recipientID: "Corrine Li", messages: Fake.Conversations.one)
        let title = (lobbyTableView.cellForRow(at: indexPath) as! LobbyCell).nameLabel.text!
            
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: title, style: .plain, target: nil, action: nil)
        self.navigationController?.pushViewController(messagesViewController, animated: true)
    }
    
}
