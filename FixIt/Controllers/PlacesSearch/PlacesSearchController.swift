//
//  PlacesSearchController.swift
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
    // References / Properties
    public lazy var placesSearchView = PlacesSearchView()
    private lazy var locationHelper = LocationHelperClass()
    // Variables
    var delegate: LocationNameProtocol?
    private var userEnteredLocation: String? = ""
    
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        view = placesSearchView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        delegate?.userEnteredLocation(forString: userEnteredLocation ?? "Not Available")
    }
    
    // MARK: - Setup
    private func setup() {
        // View
        navigationController?.isNavigationBarHidden = false
        // Text Field
        placesSearchView.textField.delegate = self
        placesSearchView.textField.addTarget(self, action: #selector(textFieldTapped(sender:)), for: .editingDidBegin)
    }
    
    // MARK: - Actions
    @objc private func textFieldTapped(sender: UITextField) {
        placesSearchView.textField.resignFirstResponder()
        let autoCompleteController = GMSAutocompleteViewController()
        autoCompleteController.delegate = self
        present(autoCompleteController, animated: true, completion: nil)
    }

} // Class End


// MARK: - Google Places Controller Extension
extension PlacesSearchController: GMSAutocompleteViewControllerDelegate {
    func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
        placesSearchView.textField.text = place.formattedAddress
        dismiss(animated: true, completion: nil)
        guard let location = place.formattedAddress else { print("Invalid Place"); return }
        locationHelper.centerMapOnLocation(forString: location) { (region) in
            self.placesSearchView.mapView.setRegion(region, animated: true)
        }
        userEnteredLocation = location
    }
    
    
    func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
        print("Error, \(error.localizedDescription)")
    }
    
    
    func wasCancelled(_ viewController: GMSAutocompleteViewController) {
        dismiss(animated: true, completion: nil)
    }
}


// MARK: - UITextField Delegate
extension PlacesSearchController: UITextFieldDelegate {
}
