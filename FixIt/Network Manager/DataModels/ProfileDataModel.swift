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
        getUserData()
    }
    
    func getUserData() {
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
            } // Switch End
        } // UserAccess End
    } // User End
    
    
    func addUserData(to key: addValue, with value: String) {
        guard let userId = Auth.auth().currentUser?.uid else { print("Error getting User Id"); return }
        getUserAccessLevel(id: userId) { (isCustomer) in
            switch isCustomer {
            case true:
                let customerData = dbReference.child("Customers").child("UsersById").child(userId)
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
                let employeeData = dbReference.child("Employees").child("UsersById").child(userId)
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
            } // isCustomer Switch End
        } // getUserAccess Func End
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
    
} // Class End
