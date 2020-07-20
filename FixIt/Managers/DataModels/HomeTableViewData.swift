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
            let userData: [UserTaskModel] = [UserTaskModel(userTaskName: userTaskName, userName: userName, userTaskDescription: userDescription, userEmail: userEmail, userLocation: userLocation, userTaskDate: userDate)]
            var userDataArray: [UserTaskModel] = []
            userDataArray = userData
            self.delegate?.retrieveUserTasks(userTaskData: userDataArray)
        }
    }
    
    // MARK: FIX: Error here, there might not be any issues
    private func getUserTasks(completion: @escaping(_ userDateAdded: String, _ taskDescription: String, _ userEmail: String?, _ userLocation: String, _ userName: String, _ userTaskName: String) -> Void) -> Void {
        guard let currentUserId = Auth.auth().currentUser?.uid else { print(ValidationError.RetrievingUser.errorDescription!); return }
        DataRetriever().retrieveUserDataToGet(id: currentUserId, data: .state) { (_, userState) in
            Constants.dbReference.child("CustomerIssues").child("OutgoingIssues").child("byState").child(userState!).child(currentUserId).observeSingleEvent(of: .value, with: { (mainSnapshot) in
                if let children = mainSnapshot.children.allObjects as? [DataSnapshot] {
                    for child in children {
                        let userAutoId: String = child.key as String
                        var autoIdArray: [String] = []
                        autoIdArray.append(userAutoId)
                        for id in autoIdArray {
                        Constants.dbReference.child("CustomerIssues").child("OutgoingIssues").child("byState").child(userState!).child(currentUserId).child(id).observeSingleEvent(of: .value, with: { (snapshot) in
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
                                print(ValidationError.RetrievingData.errorDescription!)
                            }
                        } // Loop End
                    } // Child End
                } // Children End
            }) { (error) in
                print(ValidationError.RetrievingData.errorDescription!)
            }
        }
    } // Func End
    
}
