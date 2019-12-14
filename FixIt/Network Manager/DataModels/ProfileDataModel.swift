//
//  ProfileData.swift
//  FixIt
//
//  Created by Josiah Agosto on 11/4/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation
import Firebase
import Combine

enum addValue {
    case phoneNumber
    case dateOfBirth
}

class ProfileDataModel: ObservableObject {
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var location: String = ""
    @Published var phone: String = ""
    @Published var dob: String = ""
    @Published var skill: String = ""
    @Published var phoneNumberText: String = ""
    
    init() {
        print("I AM INITIALIZED!")
        getUserData()
    }
    
    private func getUserData() {
        guard let userId = Auth.auth().currentUser?.uid else { print("Error getting User Id"); return }
        DataRetriever().getUserAccessLevel(id: userId) { (_) in
            dbReference.child("Users").child("byId").child(userId).observeSingleEvent(of: .value, with: { (snapshot) in
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
        } // UserAccess End
    } // User End
    
    
    func addUserData(to key: addValue, with value: String) {
        guard let userId = Auth.auth().currentUser?.uid else { print("Error getting User Id"); return }
        DataRetriever().getUserAccessLevel(id: userId) { (customer) in
            switch customer {
            case true:
                let customerData = dbReference.child("Users").child("byId").child(userId)
                switch key {
                case .phoneNumber:
                    let phoneKeyWithValue = ["phoneNumber": value]
                    customerData.updateChildValues(phoneKeyWithValue) { (error, _) in
                        if error != nil {
                            print(error!.localizedDescription)
                        }
                    }
                case .dateOfBirth:
                    let dobKeyWithValue = ["dateOfBirth": value]
                    customerData.updateChildValues(dobKeyWithValue) { (error, _) in
                        if error != nil {
                            print(error!.localizedDescription)
                        }
                    }
            } // Switch End
            case false:
                let employeeData = dbReference.child("Users").child("byId").child(userId)
                switch key {
                case .phoneNumber:
                    let phoneKeyWithValue = ["phoneNumber": value]
                    employeeData.updateChildValues(phoneKeyWithValue) { (error, _) in
                        if error != nil {
                            print(error!.localizedDescription)
                        }
                    }
                case .dateOfBirth:
                    let dobKeyWithValue = ["dateOfBirth": value]
                    employeeData.updateChildValues(dobKeyWithValue) { (error, _) in
                        if error != nil {
                            print(error!.localizedDescription)
                        }
                    }
                }
            } // Customer Switch End
        } // getUserAccess Func End
    } // Func End
    
} // Class End
