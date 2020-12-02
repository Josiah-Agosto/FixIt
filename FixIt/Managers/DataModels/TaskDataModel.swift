//
//  TaskDataModel.swift
//  FixIt
//
//  Created by Josiah Agosto on 11/2/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation
import Firebase

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
    
    /// Get's user's data upon initialization.
    public func retrieveUserData() {
        guard let userId = Constants.shared.currentUser else { print(ValidationError.RetrievingUser.errorDescription!); return }
        FirebaseHelperClass().getAllUserData(id: userId) { (isCustomer, email, location, name, signedUp, skill, state, phone, dob) in
            self.name = name
            self.email = email
            self.location = location
            self.phone = phone
            self.dob = dob
            self.skill = skill
        } // UserAccess End
    } // Func End
    
}
