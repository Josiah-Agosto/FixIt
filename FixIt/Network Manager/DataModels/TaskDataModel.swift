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
    
    private func retrieveUserData() {
        guard let userId = Auth.auth().currentUser?.uid else { print("Error getting User Id"); return }
        DataRetriever().getUserAccessLevel(id: userId) { (isRetrievaleCustomer) in
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
        } // Func End
    } // Func End

}
