//
//  UserTaskModel.swift
//  FixIt
//
//  Created by Josiah Agosto on 11/9/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation

struct UserTaskModel {
    var userDateAdded: String
    var taskDescription: String
    var userEmail: String?
    var userLocation: String?
    var userName: String
    var userTaskName: String
    var userId: String
    
    init(userTaskName: String, userName: String, userTaskDescription: String, userEmail: String?, userLocation: String?, userTaskDate: String, userId: String) {
        self.userTaskName = userTaskName
        self.userName = userName
        self.taskDescription = userTaskDescription
        self.userEmail = userEmail ?? "N/A"
        self.userLocation = userLocation ?? "N/A"
        self.userDateAdded = userTaskDate
        self.userId = userId
    }
    
    func toAnyObject() -> Dictionary<String, Any> {
        return ["dateAdded": userDateAdded, "description": taskDescription, "email": userEmail ?? "", "location": userLocation ?? "", "name": userName, "taskName": userTaskName, "id": userId]
    }
}
