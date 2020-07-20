//
//  LocationDataProtocol.swift
//  FixIt
//
//  Created by Josiah Agosto on 1/7/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation
import CoreLocation

protocol LocationDataProtocol {
    mutating func getLocationCoordinates(latitude: CLLocationDegrees, longitude: CLLocationDegrees)
}
