//
//  UserTaskModel.swift
//  FixIt
//
//  Created by Josiah Agosto on 11/9/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation

struct UserTaskModel: Hashable {
    var sender: String?
    var location: String?
    var description: String?
    var email: String?
    var dateAdded: String?
    
    init(data: [AnyHashable: Any]) {
        sender = data["sender"] as? String ?? ""
        location = data["location"] as? String ?? ""
        description = data["description"] as? String ?? ""
        email = data["email"] as? String ?? ""
        dateAdded = data["dateAdded"] as? String ?? ""
    }
}
