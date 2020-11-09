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

struct NewTaskFunctions {
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
    public func getUserState(completion: @escaping (_ location: String?, _ userId: String) -> Void) -> Void {
        guard let userId = Constants.shared.currentUser else { print(ValidationError.RetrievingUser.errorDescription!); return }
        Constants.shared.dbReference.child("Users").child("byId").child(userId).observeSingleEvent(of: .value, with: {
            (snapshot) in
            if let userDictionary = snapshot.value as? [String: Any] {
                let userLocation = userDictionary["location"] as? String ?? ""
                completion(userLocation, userId)
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
        
}
