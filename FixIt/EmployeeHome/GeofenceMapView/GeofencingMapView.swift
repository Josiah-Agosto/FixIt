//
//  GeofencingMapView.swift
//  FixIt
//
//  Created by Josiah Agosto on 11/28/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation
import MapKit
import CoreLocation

class GeofencingMapView: UIView {
    private var mapView: MKMapView = {
        let map = MKMapView(frame: CGRect.zero)
        return map
    }()
    private let locationManager = CLLocationManager()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        // Subviews
        self.addSubview(mapView)
        // Constraints
        setupConstriants()
    }
    
    
    private func locationSetup() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }
    
    
    private func setupConstriants() {
        mapView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        mapView.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        mapView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        mapView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
} // Class End



extension GeofencingMapView: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            print("Location Not Determined Yet")
        case .restricted:
            print("Access Restricted, Do something")
        case .denied:
            print("Access Restricted, Do something")
        case .authorizedAlways:
            print("Location Authorized")
        case .authorizedWhenInUse:
            print("Location Authorized")
        @unknown default:
            fatalError("Unknown Reason")
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let _ = locations.first {
            locationManager.startUpdatingLocation()
        }
    }
}
