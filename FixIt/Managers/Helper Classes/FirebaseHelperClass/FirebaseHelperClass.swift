//
//  FirebaseHelperClass.swift
//  FixIt
//
//  Created by Josiah Agosto on 11/11/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation
import Firebase

class FirebaseHelperClass {
    // MARK: - References / Properties
    private let globalHelper = GlobalHelper.shared
    
    // MARK: - Methods
    /// Adding User Data to Database.
    /// - Parameters:
    ///   - task: NewTask
    ///   - location: String
    public func creatingANewIssue(task: NewTask, location: String) {
        let currentUserReference = Constants.shared.dbReference.child("Users").child("byId").child(Constants.shared.currentUser ?? "")
        let taskDictionary = task.toAnyObject()
        currentUserReference.observeSingleEvent(of: .value) { (snapshot) in
            if snapshot.hasChild("openIssues") {
                self.newTask(with: currentUserReference.child("openIssues").childByAutoId(), with: taskDictionary)
            } else {
                self.appendingToATask(with: currentUserReference.child("openIssues").childByAutoId(), and: task)
            }
            self.appendUserIssueToCorrespondingState(with: task)
        }
    }
    
    /// Called when there are no open issues.
    /// - Parameters:
    ///   - databaseReference: DatabaseReference
    ///   - data: [String: Any]
    public func newTask(with databaseReference: DatabaseReference, with data: [String: Any]) {
        databaseReference.updateChildValues(data) { (error, _) in
            if let error = error {
                print(error.localizedDescription)
            }
            self.globalHelper.addingToIssueCounter()
        }
    }
    
    /// Call when there is already open issues.
    /// - Parameters:
    ///   - reference: DatabaseReference
    ///   - data: NewTask
    public func appendingToATask(with reference: DatabaseReference, and data: NewTask) {
        reference.updateChildValues(data.toAnyObject()) { (error, reference) in
            if let error = error {
                print("Updating Issue: \(error.localizedDescription)")
            }
            self.globalHelper.addingToIssueCounter()
        }
    }
    
    ///
    public func appendUserIssueToCorrespondingState(with data: NewTask) {
        let locationHelper = LocationHelperClass()
        let globalIssueReference = Constants.shared.dbReference.child("globalIssues").child("byState")
        locationHelper.getUserState(from: data.location) { (state) in
            // TODO: Fix the autoById
            globalIssueReference.child("\(state)").childByAutoId().updateChildValues(data.toAnyObject())
        }
    }
    
    ///
    public func removingUserIssueFromCorrespondingState() {
        
    }
    
}
