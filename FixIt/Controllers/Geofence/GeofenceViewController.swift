//
//  GeofenceViewController.swift
//  FixIt
//
//  Created by Josiah Agosto on 5/25/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class GeofenceViewController: UIViewController {
    // References / Properties
    public lazy var geofenceMapView = GeofencingMapView()
    // Delegate
    public var locationDelegate: LocationDataProtocol?
    
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        view = geofenceMapView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationSetup()
    }
    
    // MARK: - Setup
    private func locationSetup() {
            geofenceMapView.mapView.showsUserLocation = true
//            locationDelegate = newTaskStruct
//            locationDelegate?.getLocationCoordinates(latitude: userCoordinates.latitude, longitude: userCoordinates.longitude)
    }
    
    
//    private func createLocationSpan() {
//        guard let localCoordinates: CLLocationCoordinate2D = locationManager.location?.coordinate else { print("Error Getting Coordinates 1"); return }
//        let locationCenter: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: localCoordinates.latitude, longitude: localCoordinates.longitude)
//        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: 0.8, longitudeDelta: 0.8)
//        let region: MKCoordinateRegion = MKCoordinateRegion(center: locationCenter, span: span)
//        geofenceMapView.mapView.setRegion(region, animated: true)
//    }
    
    
//    private func createGeofence() {
//        guard let localCoordinates: CLLocationCoordinate2D = locationManager.location?.coordinate else { print("Error Getting Coordinates 2"); return }
//        let geofenceRegionCenter = CLLocationCoordinate2DMake(localCoordinates.latitude, localCoordinates.longitude)
//        let makeGeofenceRegion = CLCircularRegion(center: geofenceRegionCenter, radius: 250, identifier: "UserRadius")
//        self.locationManager.startMonitoring(for: makeGeofenceRegion)
//    }
}
