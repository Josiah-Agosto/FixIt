//
//  PlacesSearchView.swift
//  FixIt
//
//  Created by Josiah Agosto on 5/22/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class PlacesSearchView: UIView {
    // Properties / References
    let mapView: MKMapView = {
        let mapView = MKMapView(frame: CGRect.zero)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    let textField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Search"
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        return textField
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    
    private func setup() {
        // View
        // Subviews
        addSubview(mapView)
        addSubview(textField)
        // Constraints
        constraints()
    }
    
    
    private func constraints() {
        // Text Field
        textField.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        textField.widthAnchor.constraint(equalTo: widthAnchor, constant: -20).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        textField.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        // Map View
        mapView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        mapView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        mapView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        mapView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
