//
//  CustomerIssueMonitor.swift
//  FixIt
//
//  Created by Josiah Agosto on 10/24/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation

class CustomerIssueMonitor {
    // Properties / References
    static let shared = CustomerIssueMonitor()
    //
    private let globalHelper = GlobalHelper()
    //
    private let customerIssuesNotification = NotificationCenter.default
    
    public func fetchUpdates() {
        let userTasksReference = Constants.shared.dbReference.child("Users").child("byId").child(Constants.shared.currentUser ?? "")
        userTasksReference.observeSingleEvent(of: .childChanged) { [weak self] (snapshot) in
            let snapshotValue = ["snapshot": snapshot]
            self?.customerIssuesNotification.post(name: .customerIssues, object: nil, userInfo: snapshotValue)
        }
    }
    
}


//
extension Notification.Name {
    static let customerIssues = Notification.Name("customerIssues")
}
