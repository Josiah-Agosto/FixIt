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
        getUserTasks { (userDate, userDescription, userEmail, userLocation, userName, userTaskName) in
            let userData = [UserTaskModel(userTaskName: userTaskName, userName: userName, userTaskDescription: userDescription, userEmail: userEmail, userLocation: userLocation, userTaskDate: userDate)]
            var userDataArray: [UserTaskModel] = []
            userDataArray = userData
            self.delegate?.retrieveUserTasks(userTaskData: userDataArray)
        }
    }
    
    private func getUserTasks(completion: @escaping(_ userDateAdded: String, _ taskDescription: String, _ userEmail: String, _ userLocation: String, _ userName: String, _ userTaskName: String) -> Void) -> Void {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        DataRetriever().getUserState { (userState) in dbReference.child("CustomerIssues").child("OutgoingIssues").child("byState").child(userState).child(currentUserId).observeSingleEvent(of: .value, with: { (mainSnapshot) in
                if let children = mainSnapshot.children.allObjects as? [DataSnapshot] {
                    for child in children {
                        let userAutoId: String = child.key as String
                        var autoIdArray: [String] = []
                        autoIdArray.append(userAutoId)
                        // Looping through the users Tasks to get each one not just the last made
                        print("State: \(userState)")
                        for id in autoIdArray {
                            dbReference.child("CustomerIssues").child("OutgoingIssues").child("byState").child(userState).child(currentUserId).child(id).observeSingleEvent(of: .value, with: { (snapshot) in
                                if let userDictionary = snapshot.value as? [String: Any] {
                                    let userDateAdded = userDictionary["dateAdded"] as? String ?? ""
                                    let userTaskDescription = userDictionary["description"] as? String ?? ""
                                    let userEmail = userDictionary["email"] as? String ?? ""
                                    let userLocation = userDictionary["location"] as? String ?? ""
                                    let userName = userDictionary["sender"] as? String ?? ""
                                    let userTaskName = userDictionary["taskName"] as? String ?? ""
                                    completion(userDateAdded, userTaskDescription, userEmail, userLocation, userName, userTaskName)
                                }
                            }) { (error) in
                                fatalError(error.localizedDescription)
                            }
                        } // Loop End
                    } // Child End
                } // Children End
        }) { (error) in
            fatalError("\(error.localizedDescription)")
            }
        } // getUserState End
    } // Func End
    
}
