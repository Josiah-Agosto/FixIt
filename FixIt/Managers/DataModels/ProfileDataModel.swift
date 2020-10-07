//
//  ProfileDataModel.swift
//  FixIt
//
//  Created by Josiah Agosto on 11/4/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation
import Firebase

public enum AddValue {
    case location
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
    
    public func getUserData() {
        guard let userId = Auth.auth().currentUser?.uid else { print(ValidationError.RetrievingUser.errorDescription!); return }
        DataRetriever().getAllUserData(id: userId) { (isCustomer, email, location, name, signedUp, skill, state, phone, dob) in
            self.name = name
            self.email = email
            self.location = location
            self.phone = phone
            self.dob = dob
            self.skill = skill
        }
    } // GetUserData End

    
    public func addUserData(to key: AddValue, with value: String) {
        guard let userId = Auth.auth().currentUser?.uid else { print(ValidationError.RetrievingUser.errorDescription!); return }
        DataRetriever().retrieveUserDataToGet(id: userId, data: .isCustomer) { (isCustomer, _) in
            guard let isCustomer = isCustomer else { return }
            switch isCustomer {
            case true:
                let customerData = Constants.dbReference.child("Users").child("byId").child(userId)
                switch key {
                case .phoneNumber:
                    let phoneKeyWithValue = ["phoneNumber": value]
                    customerData.updateChildValues(phoneKeyWithValue) { (error, _) in
                        if error != nil {
                            print(UserError.UpdatingValues.errorDescription!)
                        }
                    }
                case .dateOfBirth:
                    let dobKeyWithValue = ["dateOfBirth": value]
                    customerData.updateChildValues(dobKeyWithValue) { (error, _) in
                        if error != nil {
                            print(UserError.UpdatingValues.errorDescription!)
                        }
                    }
                case .location:
                    let locationKeyWithValue = ["location": value]
                    customerData.updateChildValues(locationKeyWithValue) { (error, _) in
                        if error != nil {
                            print(UserError.UpdatingValues.errorDescription!)
                        }
                    }
            } // Switch End
            case false:
                let employeeData = Constants.dbReference.child("Users").child("byId").child(userId)
                switch key {
                case .phoneNumber:
                    let phoneKeyWithValue = ["phoneNumber": value]
                    employeeData.updateChildValues(phoneKeyWithValue) { (error, _) in
                        if error != nil {
                            print(UserError.UpdatingValues.errorDescription!)
                        }
                    }
                case .dateOfBirth:
                    let dobKeyWithValue = ["dateOfBirth": value]
                    employeeData.updateChildValues(dobKeyWithValue) { (error, _) in
                        if error != nil {
                            print(UserError.UpdatingValues.errorDescription!)
                        }
                    }
                case .location:
                    let locationKeyWithValue = ["location": value]
                    employeeData.updateChildValues(locationKeyWithValue) { (error, _) in
                        if error != nil {
                            print(UserError.UpdatingValues.errorDescription!)
                        }
                    }
                }
            } // Customer Switch End
        } // Data Retriever End
    } // User Data Func End
    
} // Class End
