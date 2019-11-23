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
            print(userDataArray)
            self.delegate?.retrieveUserTasks(userTaskData: userDataArray)
        }
    }
    
    private func getUserTasks(completion: @escaping(_ userDateAdded: String, _ taskDescription: String, _ userEmail: String, _ userLocation: String, _ userName: String, _ userTaskName: String) -> Void) -> Void {
        guard let currentUserId = Auth.auth().currentUser?.uid else { return }
        getUserState { (userState) in dbReference.child("CustomerIssues").child("OutgoingIssues").child("byState").child(userState).child(currentUserId).observeSingleEvent(of: .value, with: { (mainSnapshot) in
                if let children = mainSnapshot.children.allObjects as? [DataSnapshot] {
                    for child in children {
                        let userAutoId: String = child.key as String
                        var autoIdArray: [String] = []
                        autoIdArray.append(userAutoId)
                        // Looping through the users Tasks to get each one not just the last made
                        for id in autoIdArray {
                            dbReference.child("CustomerIssues").child("OutgoingIssues").child("byState").child(userState).child(currentUserId).child(id).observeSingleEvent(of: .value, with: { (snapshot) in
                                    if let userDictionary = snapshot.value as? [String: Any] {
                                        let userDateAdded = userDictionary["dateAdded"] as? String ?? "nil"
                                        let userTaskDescription = userDictionary["description"] as? String ?? "nil"
                                        let userEmail = userDictionary["email"] as? String ?? "nil"
                                        let userLocation = userDictionary["location"] as? String ?? "nil"
                                        let userName = userDictionary["sender"] as? String ?? "nil"
                                        let userTaskName = userDictionary["taskName"] as? String ?? "nil"
                                        completion(userDateAdded, userTaskDescription, userEmail, userLocation, userName, userTaskName)
                                    }
                            }) { (error) in
                                fatalError(error.localizedDescription)
                            }
                        }
                    } // Child End
                } // Children End
        }) { (error) in
            fatalError("\(error.localizedDescription)")
            }
        } // getUserState End
    } // Func End
    
    
    private func getUserState(completion: @escaping (_ userState: String) -> Void) -> Void {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        dbReference.child("Customers").child("UsersById").child(userId).observeSingleEvent(of: .value, with: { (snapshot) in
            if let userDictionary = snapshot.value as? [String: Any] {
                let userState = userDictionary["state"] as? String ?? "nil"
                completion(userState)
            }
        }) { (error) in
            fatalError("\(error.localizedDescription)")
        }
    }
}
