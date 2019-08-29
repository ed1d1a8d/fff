//
//  MapViewController.swift
//  FF
//
//  Created by Jing Lin on 8/27/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {

    let camera:GMSCameraPosition
    let mapView:GMSMapView
    let friendButton = FButton(titleText: "5 friends nearby")
    let lobbyViewController = FFNavigationController(rootViewController: LobbyViewController())
    
    let friendData:[FriendData]
    
    init(friendData: [FriendData]) {
        self.friendData = friendData
        
        self.camera = GMSCameraPosition.camera(withLatitude: 42.3601, longitude: -71.0942, zoom: 15.0)
        self.mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: 0, width: Dimensions.width, height: Dimensions.height), camera: camera)
        
        for friend in friendData {
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: friend.friendLat, longitude: friend.friendLng)
            marker.title = friend.friendName
            marker.map = mapView
        }
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.view.backgroundColor = UIColor.orange
        
        self.friendButton.addTarget(self, action: #selector(MapViewController.friendClick), for: .touchUpInside)
        
        self.view.addSubview(self.mapView)
        self.view.addSubview(self.friendButton)
        
        addConstraints()
    }
    
    func addConstraints() {
//        self.view.addConstraints(FConstraint.paddingPositionConstraints(view: self.mapView, sides: [.left, .top, .right, .bottom], padding: 0))
        
        self.view.addConstraints(FConstraint.paddingPositionConstraints(view: self.friendButton, sides: [.left, .bottom, .right], padding: 40))
        self.view.addConstraint(FConstraint.fillYConstraints(view: self.friendButton, heightRatio: 0.07))
    }

    @objc func friendClick() {
        let lobbyFunctions = lobbyViewController.topViewController as! LobbyViewController
        
        let data = [
            "Stella Yang,0.1", "Gilbert Yan,0.2", "Tony Wang,0.3",
            "Stella Yang,0.1", "Gilbert Yan,0.2", "Tony Wang,0.3",
            "Stella Yang,0.1", "Gilbert Yan,0.2", "Tony Wang,0.3",
            "Stella Yang,0.1", "Gilbert Yan,0.2", "Tony Wang,0.3"
        ]
        
        lobbyFunctions.updateLobbySource(data: data)
        self.present(lobbyViewController, animated: true, completion: nil)
    }
}

