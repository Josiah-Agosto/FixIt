//
//  NewTaskHelper.swift
//  FixIt
//
//  Created by Josiah Agosto on 6/29/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation
import Firebase
import CoreLocation.CLLocationManager

struct NewTaskHelper {
    /// Gets the users date of when the account was created
    func dateAdded() -> String {
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .long
        formatter.string(from: currentDate)
        return formatter.string(from: currentDate)
    }
        
}
