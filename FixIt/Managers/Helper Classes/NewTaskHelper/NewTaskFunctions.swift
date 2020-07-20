//
//  NewTaskFunctions.swift
//  FixIt
//
//  Created by Josiah Agosto on 6/29/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation
import Firebase
import CoreLocation.CLLocationManager

struct NewTaskFunctions: LocationDataProtocol {
    // Constants
    public var userLatitude: String = ""
    public var userLongitude: String = ""
    
    /// Gets the users date of when the account was created
    func dateAdded() -> String {
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .long
        formatter.string(from: currentDate)
        return formatter.string(from: currentDate)
    }
    
    /// Retrieves current users Location State.
    public func getUserState(completion: @escaping (_ state: String?, _ userId: String) -> Void) -> Void {
        guard let userId = Constants.currentUser else { print(ValidationError.RetrievingUser.errorDescription!); return }
        Constants.dbReference.child("Users").child("byId").child(userId).observeSingleEvent(of: .value, with: {
            (snapshot) in
            if let userDictionary = snapshot.value as? [String: Any] {
                let userState = userDictionary["state"] as? String ?? ""
                completion(userState, userId)
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    /// Retrieves user Latitude from location.
    public func getUsersLatitude() -> String {
        return userLatitude
    }
    
    /// Retrieves user Longitude from location
    public func getUsersLongitude() -> String {
        return userLongitude
    }
    
    /// Full coordinates of user Location; Use sparingly
    mutating func getLocationCoordinates(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        let latitudeString = String(latitude)
        let longitudeString = String(longitude)
        userLatitude = latitudeString
        userLongitude = longitudeString
    }
        
}
