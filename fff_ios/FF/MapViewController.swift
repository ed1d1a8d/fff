//
//  MapViewController.swift
//  FF
//
//  Created by Jing Lin on 8/27/19.
//  Copyright © 2019 Jing Lin. All rights reserved.
//

import UIKit
import CoreLocation

import GoogleMaps

class MapViewController: UIViewController {

    let locationManager = CLLocationManager()
    var currentLocation:CLLocation = CLLocation(latitude: 42.3600, longitude: -71.0972)
    
    let camera:GMSCameraPosition
    let mapView:GMSMapView
    let friendButton:FButton
    let lobbyViewController = FFNavigationController(rootViewController: LobbyViewController())
    
    let eatRequestData:[EatRequestData]
    
    init(currLocation: CLLocation, eatRequestData: [EatRequestData]) {
        self.friendButton = FButton(titleText: "\(eatRequestData.count) friends nearby")

        self.eatRequestData = eatRequestData
        self.camera = GMSCameraPosition.camera(withLatitude: 42.3601, longitude: -71.0942, zoom: 15.0)
        self.mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: 0, width: Dimensions.width, height: Dimensions.height), camera: camera)

        super.init(nibName: nil, bundle: nil)
        
        self.mapView.delegate = self
        
        for friend in eatRequestData {
            let marker = GMSMarker()
            
            marker.position = CLLocationCoordinate2D(latitude: friend.friendLat, longitude: friend.friendLng)
            marker.title = friend.friendName
            marker.map = mapView
        }
        
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
        
        enableBasicLocationServices()
    }
    
    func enableBasicLocationServices() {
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            // Request when-in-use authorization initially
            self.locationManager.requestWhenInUseAuthorization()
            break
            
        case .restricted, .denied:
            // Disable location features
            // code to disable everything until location services are enabled
            break
            
        case .authorizedWhenInUse, .authorizedAlways:
            // Enable location features
            self.locationManager.startUpdatingLocation()
            break
        }
    }
    
    func addConstraints() {        
        self.view.addConstraints(FConstraint.paddingPositionConstraints(view: self.friendButton, sides: [.left, .bottom, .right], padding: 40))
        self.view.addConstraint(FConstraint.fillYConstraints(view: self.friendButton, heightRatio: 0.07))
    }

    @objc func friendClick() {
        let lobbyFunctions = lobbyViewController.topViewController as! LobbyViewController
        
        for friend in self.eatRequestData {
            let friendLocation = CLLocation(latitude: friend.friendLat, longitude: friend.friendLng)
            let distance = self.currentLocation.distance(from: friendLocation)
            friend.distance = distance
            
            print(distance)
        }
        print("current location")
        print(self.currentLocation)

        
        lobbyFunctions.updateLobbySource(data: self.eatRequestData)
        self.present(lobbyViewController, animated: true, completion: nil)
    }
}

extension MapViewController: GMSMapViewDelegate {
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        mapView.selectedMarker = marker
        return true
    }
    
}

extension MapViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        self.currentLocation = locations.last!
    }
    
}
