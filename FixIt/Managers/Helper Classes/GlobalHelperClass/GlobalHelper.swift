//
//  GlobalHelper.swift
//  FixIt
//
//  Created by Josiah Agosto on 6/4/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

class GlobalHelper {
    // References / Properties
    static let shared = GlobalHelper()
    
    /// Takes a title and message and returns an Alert Controller which is to be presented where you want it.
    public func globalError(with title: String, and message: String? = nil, completion: @escaping((UIAlertController)) -> Void) {
        let errorController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let dismissAction = UIAlertAction(title: "Okay", style: .cancel, handler: { (action) in
        })
        errorController.addAction(dismissAction)
        completion(errorController)
    }
    
    /// Retrieves the number of current User Issues.
    public func retrieveNumberOfIssues() -> Int {
        guard let userId = Constants.currentUser else { print(ValidationError.RetrievingUser.errorDescription!); return 0 }
        var userCount: Int = 0
        Constants.dbReference.child("Users").child("byId").child(userId).observeSingleEvent(of: .value) { (snapshot) in
            if let issueCounter = snapshot.value as? [String: Any] {
                let currentUserValue = issueCounter["issueCounter"] as? Int ?? 0
                userCount = currentUserValue
            }
        }
        return userCount
    }
    
    
    public func addingToIssueCounter() {
        guard let userId = Constants.currentUser else { print(ValidationError.RetrievingUser.errorDescription!); return }
        Constants.issueCounter += 1
        Constants.dbReference.child("Users").child("byId").child(userId).updateChildValues(["issueCounter": Constants.issueCounter])
        print("Issue Counter: \(Constants.issueCounter)")
    }
}

// MARK: - String Extension
// Converts Firebase symbols that aren't accepted to acceptable ones
extension String {
    public func convertForbiddenFirebaseSymbols(from text: String) -> String {
        var input = text
        let forbiddenSymbols = [".", "#", "$", "[", "]"]
        forbiddenSymbols.forEach { (symbol) in
            if input.contains(symbol) {
                switch symbol {
                case ".":
                    input = text.replacingOccurrences(of: symbol, with: ",")
                case "#":
                    input = text.replacingOccurrences(of: symbol, with: "%")
                case "$":
                    input = text.replacingOccurrences(of: symbol, with: "&")
                case "[":
                    input = text.replacingOccurrences(of: symbol, with: "(")
                case "]":
                    input = text.replacingOccurrences(of: symbol, with: ")")
                default:
                    return
                }
            }
        }
        return input
    }
    
    
    public func reconvertSymbols(from text: String) -> String {
        var input = text
        let firebaseSymbols = [",", "%", "&", "(", ")"]
        firebaseSymbols.forEach { (symbol) in
            if input.contains(symbol) {
                switch symbol {
                case ",":
                    input = text.replacingOccurrences(of: symbol, with: ".")
                case "%":
                    input = text.replacingOccurrences(of: symbol, with: "#")
                case "&":
                    input = text.replacingOccurrences(of: symbol, with: "$")
                case "(":
                    input = text.replacingOccurrences(of: symbol, with: "[")
                case ")":
                    input = text.replacingOccurrences(of: symbol, with: "]")
                default:
                    return
                }
            }
        }
        return input
    }
    
}
