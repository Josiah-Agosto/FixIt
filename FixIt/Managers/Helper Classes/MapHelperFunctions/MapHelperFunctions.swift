//
//  MapHelperFunctions.swift
//  FixIt
//
//  Created by Josiah Agosto on 5/21/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MapHelperFunctions {
    // Properties / References
    private var locationManager: CLLocationManager?
    public var userLocationName: String? = ""
    public var userState: String? = ""
    
    convenience init(locationManager: CLLocationManager) {
        self.init()
        self.locationManager = locationManager
    }
    
    /// User Disabled Location
    public func locationRequestError(with title: String, and message: String?, completion: @escaping(UIAlertController) -> Void) {
        let locationDisabledAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let settingsAction = UIAlertAction(title: "Settings", style: .default, handler: { (_) in
            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }
            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, options: [:]) { (success) in
                }
            }
        })
        let dismissAction = UIAlertAction(title: "Dismiss", style: .cancel) { (_) in
        }
        locationDisabledAlertController.addAction(settingsAction)
        locationDisabledAlertController.addAction(dismissAction)
        completion(locationDisabledAlertController)
    }
    
    /// Accessing Users Location
    public func getUserLocationDetails(and ifError: @escaping(UIAlertController) -> ()) {
        guard let userLocation = locationManager?.location else {
            locationNotFoundAlert(with: "Unable to find Location", and: "Please make sure you have location enabled to use this app.", completion: ifError)
            return
        }
        findUsersLocationDetails(in: userLocation) { (placemark) in
            guard let placemark = placemark else { print("Error Placemarking"); return }
            if let town = placemark.locality {
                self.userLocationName = ""
                self.userLocationName = self.userLocationName ?? "Couldn't find your Location" + "\(town),"
            }
            if let state = placemark.administrativeArea {
                self.userState = ""
                self.userState = self.userState ?? "Couldn't find your Location" + "\(state)"
                self.userLocationName = self.userLocationName ?? "Couldn't find your Location" + " \(state)"
            }
        }
    }
    
    /// Location Not Found Alert
    public func locationNotFoundAlert(with title: String, and message: String? = nil, completion: @escaping(UIAlertController) -> Void) {
        let locationUnavailableAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let retryAction = UIAlertAction(title: "Retry", style: .default, handler: { (action) in
            self.locationManager?.requestLocation()
        })
        locationUnavailableAlertController.addAction(retryAction)
        completion(locationUnavailableAlertController)
    }
    
    /// Finds user location to be used to access it
    private func findUsersLocationDetails(in location: CLLocation, completion: @escaping(CLPlacemark?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            guard error == nil else {
                print("Error grabbing Location")
                completion(nil)
                return
            }
            guard let placemark = placemarks?[0] else {
                print("Error finding Placemark")
                completion(nil)
                return
            }
            completion(placemark)
        }
    }
    
    /// Creates a Location and converts it to a coordinate.
    public func getCoordinateLocation(forPlaceCalled name: String, completion: @escaping(CLLocation?, CLLocationDegrees?, CLLocationDegrees?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(name) { (placemarks, error) in
            if let error = error {
                completion(nil, nil, nil)
                print("Error Geocoding, \(error.localizedDescription)")
            }
            guard let placemark = placemarks?[0] else {
                print("Error getting Placemark, \(error!.localizedDescription)")
                completion(nil, nil, nil)
                return
            }
            guard let location = placemark.location else {
                print("Error getting Location, \(error!.localizedDescription)")
                completion(nil, nil, nil)
                return
            }
            let userLatitude = location.coordinate.latitude
            let userLongitude = location.coordinate.longitude
            completion(location, userLatitude, userLongitude)
        }
    } // Func End
    
    
    public func centerMapOnLocation(forString name: String, completion: @escaping(_ region: MKCoordinateRegion) -> Void) {
        getCoordinateLocation(forPlaceCalled: name) { (location, _, _) in
            guard let location = location else { print("Error getting Location from Text"); return }
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            completion(region)
        }
    }
}
