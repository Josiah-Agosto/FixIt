//
//  DataRetriever.swift
//  FixIt
//
//  Created by Josiah Agosto on 11/25/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation
import Firebase

public class DataRetriever {
    /// Get's the Current Users Access Level, Either 'Customer' or 'Employee'.
    public func getUserAccessLevel(id userId: String, completion: @escaping (_ isEmployee: Bool) -> Void) -> Void {
        if isCustomer == true {
            dbReference.child("Customers").child("UsersById").child(userId).observeSingleEvent(of: .value, with: { (snapshot) in
                if let userDictionary = snapshot.value as? [String: Any] {
                    let userCustomer = userDictionary["employee"] as? Bool ?? false
                    completion(userCustomer)
                }
            }) { (error) in
                print(error.localizedDescription)
            }
        } else {
            dbReference.child("Employees").child("UsersById").child(userId).observeSingleEvent(of: .value, with: { (snapshot) in
                if let userDictionary = snapshot.value as? [String: Any] {
                    let userEmployee = userDictionary["employee"] as? Bool ?? true
                    completion(userEmployee)
                }
            }) { (error) in
                print(error.localizedDescription)
            }
        } // Else End
    } // Func End
    
    /// Returns the Current User's 'State' or else nil.
    public func getUserState(completion: @escaping (_ userState: String) -> Void) -> Void {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        switch isCustomer {
        case true:
            dbReference.child("Customers").child("UsersById").child(userId).observeSingleEvent(of: .value, with: { (snapshot) in
                if let userDictionary = snapshot.value as? [String: Any] {
                    let customerState = userDictionary["state"] as? String ?? "nil"
                    completion(customerState)
                }
            }) { (error) in
                fatalError("\(error.localizedDescription)")
            }
        case false:
            dbReference.child("Employees").child("UsersById").child(userId).observeSingleEvent(of: .value, with: { (snapshot) in
                if let userDictionary = snapshot.value as? [String: Any] {
                    let employeeState = userDictionary["state"] as? String ?? "nil"
                    completion(employeeState)
                }
            }) { (error) in
                fatalError("\(error.localizedDescription)")
            }
        }
        
    } // Func End
    
}
