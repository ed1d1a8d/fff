//
//  FriendsTableView.swift
//  FF
//
//  Created by Stella Yang on 8/30/19.
//  Copyright © 2019 Stella Yang. All rights reserved.
//

import UIKit

class FriendsTableView: UITableView, UITableViewDelegate {
    
    var lobbySource:[FriendData] = []
    
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

extension FriendsTableView: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.lobbySource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = self.lobbySource[indexPath.row]
        let cell = LobbyCell(data: data)
        
        return cell
    }
    
    func updateData(data: [FriendData]) {
        self.lobbySource = data
        self.reloadData()
        self.layoutIfNeeded()
    }
    
}
