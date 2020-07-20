//
//  DataRetriever.swift
//  FixIt
//
//  Created by Josiah Agosto on 11/25/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit
import Firebase

public enum AccessibleData: String {
    case email = "email"
    case isCustomer = "isCustomer"
    case location = "location"
    case name = "name"
    case signedUp = "signedUp"
    case skill = "skill"
    case state = "state"
}


public class DataRetriever {
    private var viewControllerPresented: UIViewController!
    
    // Get User Data
    public func retrieveUserDataToGet(id userId: String, data fromEnum: AccessibleData, completionHandler: @escaping(_ boolData: Bool?, _ stringData: String?) -> Void) {
        switch fromEnum {
        case .email:
            Constants.dbReference.child("Users").child("byId").child(userId).observeSingleEvent(of: .value, with: { (snapshot) in
                if let userDictionary = snapshot.value as? [String: Any] {
                    let userAccess = userDictionary["email"] as? String ?? ""
                    let convertedString = userAccess.reconvertSymbols(from: userAccess)
                    completionHandler(nil, convertedString)
                }
            }) { (error) in
                print(ValidationError.RetrievingData.errorDescription!)
            }
        case .isCustomer:
            Constants.dbReference.child("Users").child("byId").child(userId).observeSingleEvent(of: .value, with: { (snapshot) in
                if let userDictionary = snapshot.value as? [String: Any] {
                    let userAccess = userDictionary["isCustomer"] as? Bool ?? false
                    completionHandler(userAccess, nil)
                }
            }) { (error) in
                print(ValidationError.RetrievingData.errorDescription!)
            }
        case .location:
            Constants.dbReference.child("Users").child("byId").child(userId).observeSingleEvent(of: .value, with: { (snapshot) in
                if let userDictionary = snapshot.value as? [String: Any] {
                    let userAccess = userDictionary["location"] as? String ?? ""
                    completionHandler(nil, userAccess)
                }
            }) { (error) in
                print(ValidationError.RetrievingData.errorDescription!)
            }
        case .name:
            Constants.dbReference.child("Users").child("byId").child(userId).observeSingleEvent(of: .value, with: { (snapshot) in
                if let userDictionary = snapshot.value as? [String: Any] {
                    let userAccess = userDictionary["name"] as? String ?? ""
                    completionHandler(nil, userAccess)
                }
            }) { (error) in
                print(error.localizedDescription)
            }
        case .signedUp:
            Constants.dbReference.child("Users").child("byId").child(userId).observeSingleEvent(of: .value, with: { (snapshot) in
                if let userDictionary = snapshot.value as? [String: Any] {
                    let userAccess = userDictionary["signedUp"] as? String ?? ""
                    completionHandler(nil, userAccess)
                }
            }) { (error) in
                print(ValidationError.RetrievingData.errorDescription!)
            }
        case .skill:
            Constants.dbReference.child("Users").child("byId").child(userId).observeSingleEvent(of: .value, with: { (snapshot) in
                if let userDictionary = snapshot.value as? [String: Any] {
                    let userAccess = userDictionary["skill"] as? String ?? ""
                    completionHandler(nil, userAccess)
                }
            }) { (error) in
                print(ValidationError.RetrievingData.errorDescription!)
            }
        case .state:
            Constants.dbReference.child("Users").child("byId").child(userId).observeSingleEvent(of: .value, with: { (snapshot) in
                if let userDictionary = snapshot.value as? [String: Any] {
                    let userAccess = userDictionary["state"] as? String ?? ""
                    completionHandler(nil, userAccess)
                }
            }) { (error) in
                print(ValidationError.RetrievingData.errorDescription!)
            }
        }
    } // Func End
    
    
    public func getAllUserData(id userId: String, completion: @escaping (_ isCustomer: Bool, _ email: String, _ location: String, _ name: String, _ signedUp: String, _ skill: String, _ state: String, _ userPhone: String, _ userDob: String) -> Void) -> Void {
        Constants.dbReference.child("Users").child("byId").child(userId).observeSingleEvent(of: .value, with: { (snapshot) in
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
    

    public func saveSetting(for object: Bool, forKey key: String) {
        Constants.defaults.set(object, forKey: key)
    }
    
    
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
    
    
    public func testIfLoggedInWorks() -> UIViewController {
        let group = DispatchGroup()
        let localLogin = Constants.defaults.object(forKey: "logInKey") as? Bool
        guard let safeLocalLogin = localLogin else { print("Error with Log In Key"); return UIViewController() }
        print("Safe Login, \(safeLocalLogin)")
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
    
} // Class End
