//
//  MapFunctions.swift
//  FixIt
//
//  Created by Josiah Agosto on 11/29/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation
import CoreLocation

class MapFunctions {
    // Creates a Location and converts it to a coordinate.
    public func getCoordinateLocation(forPlaceCalled name: String, completion: @escaping(CLLocation?, String?, String?) -> Void) {
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
            completion(location, String(userLatitude), String(userLongitude))
        }
    }
    
}
