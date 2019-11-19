//
//  StatesModel.swift
//  FixIt
//
//  Created by Josiah Agosto on 11/2/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation
import Firebase
import Combine

class TaskDataModel: ObservableObject {
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var location: String = ""
    @Published var phone: String = ""
    @Published var dob: String = ""
    @Published var skill: String = ""
    
    init() {
        retrieveUserData()
    }
    
    func retrieveUserData() {
        guard let userId = Auth.auth().currentUser?.uid else { print("Error getting User Id"); return }
        getUserAccessLevel(id: userId) { (isCustomer) in
            switch isCustomer {
            case true:
                dbReference.child("Customers").child("UsersById").child(userId).observeSingleEvent(of: .value, with: { (snapshot) in
                    if let userDictionary = snapshot.value as? [String: Any] {
                        let userName = userDictionary["name"] as? String ?? ""
                        let userEmail = userDictionary["email"] as? String ?? ""
                        let userLocation = userDictionary["location"] as? String ?? ""
                        let userPhone = userDictionary["phoneNumber"] as? String ?? ""
                        let userDob = userDictionary["dateOfBirth"] as? String ?? ""
                        self.name = userName
                        self.email = userEmail
                        self.location = userLocation
                        self.phone = userPhone
                        self.dob = userDob
                    }
                }) { (error) in
                    print(error.localizedDescription)
                }
            case false:
                dbReference.child("Employees").child("UsersById").child(userId).observeSingleEvent(of: .value, with: { (snapshot) in
                    if let userDictionary = snapshot.value as? [String: Any] {
                        let userName = userDictionary["name"] as? String ?? ""
                        let userEmail = userDictionary["email"] as? String ?? ""
                        let userLocation = userDictionary["location"] as? String ?? ""
                        let userPhone = userDictionary["phoneNumber"] as? String ?? ""
                        let userDob = userDictionary["dateOfBirth"] as? String ?? ""
                        let userSkill = userDictionary["skill"] as? String ?? ""
                        self.name = userName
                        self.email = userEmail
                        self.location = userLocation
                        self.phone = userPhone
                        self.dob = userDob
                        self.skill = userSkill
                    }
                }) { (error) in
                    print(error.localizedDescription)
                }
            }
        }
    } // Func End
    
    
    private func getUserAccessLevel(id userId: String, completion: @escaping (_ isEmployee: Bool) -> Void) -> Void {
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

}
