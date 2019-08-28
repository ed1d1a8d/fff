//
//  FTableView.swift
//  FF
//
//  Created by Jing Lin on 8/27/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit

class LobbyTableView: UITableView, UITableViewDelegate {
    
    var lobbySource:[String] = []
    
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.lobbySource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = self.lobbySource[indexPath.row]
        print(data)
        let cell = LobbyCell(textData: data)
        
        return cell
    }
    
    func updateData(data: [String]) {
        self.lobbySource = data
        self.reloadData()
    }
    
}
