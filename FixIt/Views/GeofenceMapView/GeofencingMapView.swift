//
//  GeofencingMapView.swift
//  FixIt
//
//  Created by Josiah Agosto on 11/28/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation
import MapKit

class GeofencingMapView: UIView {
    // Properties / References
    public lazy var mapView: MKMapView = {
        let map = MKMapView(frame: CGRect.zero)
        map.translatesAutoresizingMaskIntoConstraints = false
        return map
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    
    private func setup() {
        // Subviews
        addSubview(mapView)
        // Constraints
        constraints()
    }
    
    
    private func constraints() {
        mapView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        mapView.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        mapView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        mapView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
} // Class End
