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

func timeIntervalString(_ interval: TimeInterval) -> String {
    let hours = Int(interval) / 3600
    let minutes = Int(interval) / 60 % 60
    let seconds = Int(interval) % 60
    return String(format:"%02i:%02i:%02i", hours, minutes, seconds)
}

class MapViewController: OptionsViewController {

    let locationManager = CLLocationManager()
    var currentLocation:CLLocation = CLLocation(latitude: 42.3600, longitude: -71.0972)

    var lobbyExpirationDate: Date
    let lobbyExpirationButton: FButton
    var lobbyExpirationDisplayLink: CADisplayLink = CADisplayLink()

    let camera: GMSCameraPosition
    let mapView: GMSMapView
    let friendButton: FButton

    let lobbyViewController = FFNavigationController(rootViewController: LobbyViewController())

    //let friendData:[FriendData]
    let eatRequestData:[EatRequestData]

    init(currLocation: CLLocation, eatRequestData: [EatRequestData], lobbyExpirationDate: Date?) {
        self.lobbyExpirationDate = lobbyExpirationDate ?? Date.distantFuture // TODO: Use backend for default
        self.lobbyExpirationButton = FButton(titleText: timeIntervalString(self.lobbyExpirationDate.timeIntervalSinceNow))

        self.friendButton = FButton(titleText: "\(eatRequestData.count) friends nearby")

        self.eatRequestData = eatRequestData
        self.camera = GMSCameraPosition.camera(withLatitude: 42.3601, longitude: -71.0942, zoom: 15.0)
        self.mapView = GMSMapView.map(withFrame: CGRect(x: 0, y: 0, width: Dimensions.width, height:
            Dimensions.height), camera: camera)

        super.init()

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

        self.view.backgroundColor = UIColor.orange

        self.friendButton.addTarget(self, action: #selector(MapViewController.friendClick), for: .touchUpInside)
        self.lobbyExpirationButton.addTarget(self, action: #selector(MapViewController.lobbyExpirationButtonClick), for: .touchUpInside)

        self.view.addSubview(self.mapView)
        self.view.addSubview(self.friendButton)
        self.view.addSubview(self.lobbyExpirationButton)

        addConstraints()

        enableBasicLocationServices()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.lobbyExpirationDisplayLink = CADisplayLink(target: self, selector: #selector(updateLobbyExpirationButton))
        self.lobbyExpirationDisplayLink.add(to: .current, forMode: .common)
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.lobbyExpirationDisplayLink.invalidate()
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

        self.view.addConstraints(FConstraint.paddingPositionConstraints(view: self.lobbyExpirationButton, sides: [.right, .top], padding: 40))
        self.view.addConstraint(FConstraint.fillXConstraints(view: self.lobbyExpirationButton, widthRatio: 0.3))
        self.view.addConstraint(FConstraint.fillYConstraints(view: self.lobbyExpirationButton, heightRatio: 0.1))
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

    @objc func updateLobbyExpirationButton() {
        let timeTillExpiration: TimeInterval = self.lobbyExpirationDate.timeIntervalSinceNow
        guard timeTillExpiration >= 0 else {
            self.dismiss(animated: true, completion: nil)
            return
        }
        self.lobbyExpirationButton.setTitle(timeIntervalString(timeTillExpiration), for: .normal)
    }

    @objc func lobbyExpirationButtonClick() {
        let vc = FFNavigationController(rootViewController: LobbyExpirationViewController(oldExpirationDate: self.lobbyExpirationDate, onDismissCallback: {self.lobbyExpirationDate = $0}))
        self.present(vc, animated: true, completion: nil)
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
