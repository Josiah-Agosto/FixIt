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
    
    init(userTaskName: String, userName: String, userTaskDescription: String, userEmail: String?, userLocation: String?, userTaskDate: String) {
        self.userTaskName = userTaskName
        self.userName = userName
        self.taskDescription = userTaskDescription
        self.userEmail = userEmail ?? "Add Email in Profile"
        self.userLocation = userLocation ?? "Unavailable Location"
        self.userDateAdded = userTaskDate
    }
}
