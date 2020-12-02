//
//  FirebaseHelperClass.swift
//  FixIt
//
//  Created by Josiah Agosto on 11/11/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation
import Firebase

// TODO: Look into .observe instead of .observeSingleEvent

class FirebaseHelperClass {
    // MARK: - References / Properties
    private var viewControllerPresented: UIViewController!
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
            self.addingToIssueCounter()
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
            self.addingToIssueCounter()
        }
    }
    
    ///
    public func appendUserIssueToCorrespondingState(with data: NewTask) {
        let locationHelper = LocationHelperClass()
        let globalIssueReference = Constants.shared.dbReference.child("globalIssues").child("byState")
        locationHelper.getUserState(from: data.location) { (state) in
            globalIssueReference.child("\(state)").childByAutoId().updateChildValues(data.toAnyObject())
        }
    }
    
    
    public func addingToIssueCounter() {
        guard let userId = Constants.shared.currentUser else { print(ValidationError.RetrievingUser.errorDescription!); return }
        Constants.shared.issueCounter += 1
        Constants.shared.dbReference.child("Users").child("byId").child(userId).updateChildValues(["issueCounter": Constants.shared.issueCounter])
    }
    
    ///
    public func removingUserIssueFromCorrespondingState() {
        guard let userId = Constants.shared.currentUser else { print(ValidationError.RetrievingUser.errorDescription!); return }
        // TODO: Fix so it doesn't go into negatives.
        Constants.shared.issueCounter -= 1
        Constants.shared.dbReference.child("Users").child("byId").child(userId).updateChildValues(["issueCounter": Constants.shared.issueCounter])
    }
    
    /// Only get's the number of user Issues.
    public func numberOfUserIssues(completion: @escaping(Int) -> Void) {
        guard let currentUserId = Constants.shared.currentUser else { print(ValidationError.RetrievingUser.errorDescription!); return }
        let openIssues = Constants.shared.dbReference.child("Users").child("byId").child(currentUserId).child("openIssues")
        openIssues.observeSingleEvent(of: .value) { (snapshot) in
            let issues = snapshot.childrenCount
            let issuesInt = Int(issues)
            completion(issuesInt)
        }
    }
    
    // Get User Data
    public func retrieveUserDataToGet(id userId: String, data fromEnum: AccessibleData, completionHandler: @escaping(_ boolData: Bool?, _ stringData: String?) -> Void) {
        switch fromEnum {
        case .email:
            Constants.shared.dbReference.child("Users").child("byId").child(userId).observeSingleEvent(of: .value, with: { (snapshot) in
                if let userDictionary = snapshot.value as? [String: Any] {
                    let userAccess = userDictionary["email"] as? String ?? ""
                    let convertedString = userAccess.reconvertSymbols(from: userAccess)
                    completionHandler(nil, convertedString)
                }
            }) { (error) in
                print(ValidationError.RetrievingData.errorDescription!)
            }
        case .isCustomer:
            Constants.shared.dbReference.child("Users").child("byId").child(userId).observeSingleEvent(of: .value, with: { (snapshot) in
                if let userDictionary = snapshot.value as? [String: Any] {
                    let userAccess = userDictionary["isCustomer"] as? Bool ?? false
                    completionHandler(userAccess, nil)
                }
            }) { (error) in
                print(ValidationError.RetrievingData.errorDescription!)
            }
        case .location:
            Constants.shared.dbReference.child("Users").child("byId").child(userId).observeSingleEvent(of: .value, with: { (snapshot) in
                if let userDictionary = snapshot.value as? [String: Any] {
                    let userAccess = userDictionary["location"] as? String ?? ""
                    completionHandler(nil, userAccess)
                }
            }) { (error) in
                print(ValidationError.RetrievingData.errorDescription!)
            }
        case .name:
            Constants.shared.dbReference.child("Users").child("byId").child(userId).observeSingleEvent(of: .value, with: { (snapshot) in
                if let userDictionary = snapshot.value as? [String: Any] {
                    let userAccess = userDictionary["name"] as? String ?? ""
                    completionHandler(nil, userAccess)
                }
            }) { (error) in
                print(error.localizedDescription)
            }
        case .signedUp:
            Constants.shared.dbReference.child("Users").child("byId").child(userId).observeSingleEvent(of: .value, with: { (snapshot) in
                if let userDictionary = snapshot.value as? [String: Any] {
                    let userAccess = userDictionary["signedUp"] as? String ?? ""
                    completionHandler(nil, userAccess)
                }
            }) { (error) in
                print(ValidationError.RetrievingData.errorDescription!)
            }
        case .skill:
            Constants.shared.dbReference.child("Users").child("byId").child(userId).observeSingleEvent(of: .value, with: { (snapshot) in
                if let userDictionary = snapshot.value as? [String: Any] {
                    let userAccess = userDictionary["skill"] as? String ?? ""
                    completionHandler(nil, userAccess)
                }
            }) { (error) in
                print(ValidationError.RetrievingData.errorDescription!)
            }
        case .state:
            Constants.shared.dbReference.child("Users").child("byId").child(userId).observeSingleEvent(of: .value, with: { (snapshot) in
                if let userDictionary = snapshot.value as? [String: Any] {
                    let userAccess = userDictionary["state"] as? String ?? ""
                    completionHandler(nil, userAccess)
                }
            }) { (error) in
                print(ValidationError.RetrievingData.errorDescription!)
            }
        }
    } // Func End
    
    // Retrieves all current user data.
    public func getAllUserData(id userId: String, completion: @escaping (_ isCustomer: Bool, _ email: String, _ location: String, _ name: String, _ signedUp: String, _ skill: String, _ state: String, _ userPhone: String, _ userDob: String) -> Void) -> Void {
        Constants.shared.dbReference.child("Users").child("byId").child(userId).observeSingleEvent(of: .value, with: { (snapshot) in
            if let userDictionary = snapshot.value as? [String: Any] {
                let customerBool = userDictionary["isCustomer"] as? Bool ?? false
                let userEmail = userDictionary["email"] as? String ?? ""
                let convertedEmail = userEmail.reconvertSymbols(from: userEmail)
                let userLocation = userDictionary["location"] as? String ?? ""
                let userName = userDictionary["name"] as? String ?? ""
                let signedUp = userDictionary["signedUp"] as? String ?? ""
                let skill = userDictionary["skill"] as? String ?? ""
                let state = userDictionary["state"] as? String ?? ""
                let userPhone = userDictionary["phoneNumber"] as? String ?? ""
                let userDob = userDictionary["dateOfBirth"] as? String ?? ""
                completion(customerBool, convertedEmail, userLocation, userName, signedUp, skill, state, userPhone, userDob)
            }
        }) { (error) in
            print(ValidationError.RetrievingData.errorDescription!)
        }
    }
    
    // Saves users login setting.
    public func saveSetting(for object: Bool, forKey key: String) {
        Constants.shared.defaults.set(object, forKey: key)
    }
    
    // Checks to see if logging in user is a customer.
    private func checksIfUserIsCustomer(completion: @escaping (_ isUserCustomer: Bool) -> Void) -> Void {
        guard let userId = Auth.auth().currentUser?.uid else { print(ValidationError.RetrievingUser.errorDescription!); return }
        var retrievedBoolIsCustomer: Bool = false
        print("Before Getting Data: \(retrievedBoolIsCustomer)")
        self.retrieveUserDataToGet(id: userId, data: .isCustomer) { (isCustomer, _) in
            guard let isCustomer = isCustomer else { return }
            switch isCustomer {
            case true:
                retrievedBoolIsCustomer = true
                completion(retrievedBoolIsCustomer)
            case false:
                retrievedBoolIsCustomer = false
                completion(retrievedBoolIsCustomer)
            }
        }
    }
    
    // Checks if user is customer or employee and returns appropriate controller.
    public func testIfLoggedInWorks() -> UIViewController {
        let group = DispatchGroup()
        let localLogin = Constants.shared.defaults.object(forKey: "logInKey") as? Bool
        guard let safeLocalLogin = localLogin else { print("Error with Log In Key"); return UIViewController() }
        switch safeLocalLogin {
        case true:
            group.enter()
            checksIfUserIsCustomer { (isUserCustomer) in
                switch isUserCustomer {
                case true:
                    let customerHome = CustomerViewController()
                    self.viewControllerPresented = customerHome
                case false:
                    let employeeHome = EmployeeViewController()
                    self.viewControllerPresented = employeeHome
                }
                group.leave()
            }
            group.notify(queue: .global()) {
                // TODO: Fix this issue
                // Hold off here
            }
        case false:
            let loginScreen = LoginScreen()
            self.viewControllerPresented = loginScreen
        }
        return UIViewController()
    } // Func End
    
}
