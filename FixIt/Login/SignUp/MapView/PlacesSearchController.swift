//
//  ViewController.swift
//  MapKitPlayground
//
//  Created by Josiah Agosto on 6/9/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
import GooglePlaces
import Firebase

class PlacesSearchController: UIViewController {
    let mapView: MKMapView = {
        let mapView = MKMapView(frame: CGRect.zero)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    let textField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Search City"
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    // Constants
    private let locationManager = CLLocationManager()
    // Variables
    var delegate: LocationNameProtocol?
    private var userEnteredLocation: String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        locationSetup()
        setupConstraints()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        delegate?.userEnteredLocation(forString: userEnteredLocation ?? "")
    }
    
// MARK: - Setup
    private func setup() {
        // Miscellaneous
        self.navigationController?.isNavigationBarHidden = false
        // Text Field
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldTapped(sender:)), for: .editingDidBegin)
        // Subviews
        self.view.addSubview(mapView)
        self.view.addSubview(textField)
    }
    
    
    private func locationSetup() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }
    
// MARK: Actions
    @objc private func textFieldTapped(sender: UITextField) {
        print("Text Field Tapped")
        self.textField.resignFirstResponder()
        let autoCompleteController = GMSAutocompleteViewController()
        autoCompleteController.delegate = self
        present(autoCompleteController, animated: true, completion: nil)
    }
    
// MARK: Functions
    private func getCoordinateLocation(forPlaceCalled name: String, completion: @escaping(CLLocation?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(name) { (placemarks, error) in
            if let error = error {
                completion(nil)
                print("Error Geocoding, \(error.localizedDescription)")
            }
            
            guard let placemark = placemarks?[0] else {
                print("Error getting Placemark, \(error!.localizedDescription)")
                completion(nil)
                return
            }
            
            guard let location = placemark.location else {
                print("Error getting Location, \(error!.localizedDescription)")
                completion(nil)
                return
            }
            completion(location)
        }
    }
    
    
    private func centerMapOnLocation(forString name: String) {
        MapFunctions().getCoordinateLocation(forPlaceCalled: name) { (location, _, _) in
            guard let location = location else { print("Error getting Location from Text"); return }
            let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            self.mapView.setRegion(region, animated: true)
        }
    }
    
// MARK: Constraints
    private func setupConstraints() {
        // Text Field
        textField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textField.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textField.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
        // Map View
        mapView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mapView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        mapView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        mapView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
} // Class End


// Google Places Controller Extension
extension PlacesSearchController: GMSAutocompleteViewControllerDelegate {
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        textField.text = place.formattedAddress
        dismiss(animated: true, completion: nil)
        guard let location = place.formattedAddress else { print("Invalid Place"); return }
        centerMapOnLocation(forString: location)
        userEnteredLocation = location
    }
    
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error, \(error.localizedDescription)")
    }
    
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
}


// MARK: UITextField Delegate
extension PlacesSearchController: UITextFieldDelegate {
}


// MARK: Location Manager Delegate
extension PlacesSearchController: CLLocationManagerDelegate {
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
}
