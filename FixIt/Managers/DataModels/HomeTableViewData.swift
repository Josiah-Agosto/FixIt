//
//  HomeTableViewData.swift
//  FixIt
//
//  Created by Josiah Agosto on 11/21/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation
import Firebase

class HomeTableViewData {
    var delegate: HomeTableViewDataProtocol?
    
    init() {
        
    }
    

    private func getUserTasks(completion: @escaping(_ userDateAdded: String, _ taskDescription: String, _ userEmail: String, _ userLocation: String, _ userName: String, _ userTaskName: String) -> Void) {
        guard let currentUserId = Auth.auth().currentUser?.uid else { print(ValidationError.RetrievingUser.errorDescription!); return }
        let openIssues = Constants.dbReference.child("Users").child("byId").child(currentUserId).child("openIssues")
        openIssues.observeSingleEvent(of: .value) { (snapshot) in
            if let issues = snapshot.value as? [String: Any] {
                
            }
        }
    } // Func End
    
}
