//
//  DataRetriever.swift
//  FixIt
//
//  Created by Josiah Agosto on 11/25/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation
import Firebase

class DataRetriever {
    // Get's the Current Users Access Level, Either 'Customer' or 'Employee'.
    public func getUserAccessLevel(id userId: String, completion: @escaping (_ userAccess: Bool) -> Void) {
        dbReference.child("Users").child("byId").child(userId).observeSingleEvent(of: .value, with: { (snapshot) in
            if let userDictionary = snapshot.value as? [String: Any] {
                let userAccess = userDictionary["isCustomer"] as? Bool ?? false
                completion(userAccess)
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    } // Func End
    
    // Returns the Current User's 'State' or else nil.
    public func getUserState(completion: @escaping (_ selection: String) -> Void) -> Void {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        dbReference.child("Users").child("byId").child(userId).observeSingleEvent(of: .value, with: { (snapshot) in
            if let userDictionary = snapshot.value as? [String: Any] {
                let userData = userDictionary["state"] as? String ?? ""
                completion(userData)
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    } // Func End
    
// MARK: - Save Logged In State
    public func saveSetting() {
        defaults.set(loggedIn, forKey: "logInKey")
    }
}
