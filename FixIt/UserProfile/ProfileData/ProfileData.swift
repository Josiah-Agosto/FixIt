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

class ProfileData: ObservableObject {
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var location: String = ""
    @Published var phoneNumberText: String = ""
    
    init() {
        getUserData()
        
    }
    
    func getUserData() {
        let userId = Auth.auth().currentUser?.uid
        dbReference.child("Customers").child(userId!).observeSingleEvent(of: .value, with: { (snapshot) in
            if let userDictionary = snapshot.value as? [String: Any] {
                let userName = userDictionary["name"] as? String ?? ""
                let userEmail = userDictionary["email"] as? String ?? ""
                let userLocation = userDictionary["location"] as? String ?? ""
                DispatchQueue.main.async {
                    self.name = userName
                    self.email = userEmail
                    self.location = userLocation
                }
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    
    func addUserData(to key: addValue, with value: String) {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let customerData = dbReference.child("Customers").child(userId)
        switch key {
        case .phoneNumber:
            let phoneKeyWithValue = ["phoneNumber": value]
            customerData.updateChildValues(phoneKeyWithValue) { (error, _) in
                if error != nil {
                    print(error!.localizedDescription)
                }
            }
        case .dateOfBirth:
            let dobKeyWithValue = ["datOfBirth": value]
            customerData.updateChildValues(dobKeyWithValue) { (error, _) in
                if error != nil {
                    print(error!.localizedDescription)
                }
            }
        } // Switch End
    } // Func End
    
} // Class End
