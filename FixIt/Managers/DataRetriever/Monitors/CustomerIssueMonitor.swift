//
//  CustomerIssueMonitor.swift
//  FixIt
//
//  Created by Josiah Agosto on 10/24/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation

// TODO: Add an observer to update user issueCounter to appropriate number.
class CustomerIssueMonitor {
    // Properties / References
    static let shared = CustomerIssueMonitor()
    // Shared Property
    private let globalHelper = GlobalHelper.shared
    // Notifications
    private let customerAddedNotification = NotificationCenter.default
    private let customerChangedNotification = NotificationCenter.default
    private let customerRemovedNotification = NotificationCenter.default
    
    // Fetches and listens for changes in firebase data.
    public func fetchUpdates() {
        childAdded()
        childChanged()
        childRemoved()
    }
    
    // Listens for child Added.
    private func childAdded() {
        let userTasksReference = Constants.shared.dbReference.child("Users").child("byId").child(Constants.shared.currentUser ?? "").child("openIssues")
        userTasksReference.observe(.childAdded) { [weak self] (snapshot) in
            let snapshotValue = ["snapshot": snapshot]
            self?.customerAddedNotification.post(name: .issuesAdded, object: nil, userInfo: snapshotValue)
        }
    }
    
    // Listens for child changed.
    private func childChanged() {
        let userTasksReference = Constants.shared.dbReference.child("Users").child("byId").child(Constants.shared.currentUser ?? "").child("openIssues")
        userTasksReference.observe(.childChanged) { [weak self] (snapshot) in
            let snapshotValue = ["snapshot": snapshot]
            self?.customerAddedNotification.post(name: .issuesChanged, object: nil, userInfo: snapshotValue)
        }
    }
    
    // Listens for child removed.
    private func childRemoved() {
        let userTasksReference = Constants.shared.dbReference.child("Users").child("byId").child(Constants.shared.currentUser ?? "").child("openIssues")
        userTasksReference.observe(.childRemoved) { [weak self] (snapshot) in
            let snapshotValue = ["snapshot": snapshot]
            self?.customerAddedNotification.post(name: .issuesRemoved, object: nil, userInfo: snapshotValue)
        }
    }
    
}


/// Notification Names
extension Notification.Name {
    static let issuesAdded = Notification.Name("issuesAdded")
    static let issuesChanged = Notification.Name("issuesChanged")
    static let issuesRemoved = Notification.Name("issuesRemoved")
}
