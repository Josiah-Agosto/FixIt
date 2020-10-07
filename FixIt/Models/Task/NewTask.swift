//
//  NewTask.swift
//  FixIt
//
//  Created by Josiah Agosto on 7/21/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation

struct NewTask: Codable {
    let id: String
    let taskName: String
    let description: String
    let email: String
    let location: String
    let sender: String
    let date: String
    
    func toAnyObject() -> Dictionary<String, Any> {
        return ["id": id, "taskName": taskName, "description": description, "email": email, "location": location, "sender": sender, "date": date]
    }
}
