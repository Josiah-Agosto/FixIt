//
//  CustomerTableViewData.swift
//  FixIt
//
//  Created by Josiah Agosto on 11/21/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation
import Firebase

class CustomerTableViewData {
    // MARK: - References / Properties
    var delegate: HomeTableViewDataProtocol?
    // Tasks
    /// Retrieves users Tasks.
    public func getUserTasks() {
        guard let currentUserId = Auth.auth().currentUser?.uid else { print(ValidationError.RetrievingUser.errorDescription!); return }
        let openIssues = Constants.shared.dbReference.child("Users").child("byId").child(currentUserId).child("openIssues")
        var userTasks: [UserTaskModel] = []
        openIssues.observeSingleEvent(of: .value) { (snapshot) in
            for issue in snapshot.children {
                let snap = issue as! DataSnapshot
                let model = snap.value as! [String: Any]
                let date = model["date"] as! String
                let description = model["description"] as! String
                let email = model["email"] as? String
                let id = model["id"] as! String
                let location = model["location"] as? String
                let sender = model["sender"] as! String
                let taskName = model["taskName"] as! String
                userTasks.append(UserTaskModel(userTaskName: taskName, userName: sender, userTaskDescription: description, userEmail: email, userLocation: location, userTaskDate: date, userId: id))
            }
            self.delegate?.customerIssueTasks = userTasks
        }
    } // Func End

    /// Retrieves the number of current User Issues.
    public func retrieveNumberOfIssues(completion: @escaping(_ issues: Int) -> Void) {
        let group = DispatchGroup()
        guard let userId = Constants.shared.currentUser else { print(ValidationError.RetrievingUser.errorDescription!); return }
        var userCount: Int = 0
        group.enter()
        Constants.shared.dbReference.child("Users").child("byId").child(userId).observeSingleEvent(of: .value) { (snapshot) in
            if let issueCounter = snapshot.value as? [String: Any] {
                let currentUserValue = issueCounter["issueCounter"] as? Int ?? 0
                userCount = currentUserValue
                group.leave()
            }
        }
        group.notify(queue: .global()) {
            self.delegate?.numberOfIssues = userCount
            self.delegate?.hasIssues = self.containsAnIssue(from: userCount)
            completion(userCount)
        }
    }
    
    /// Checks if inputed number is zero.
    private func containsAnIssue(from number: Int) -> Bool {
        switch number {
            case 0:
                return false
            default:
                return true
        }
    }
    
}
