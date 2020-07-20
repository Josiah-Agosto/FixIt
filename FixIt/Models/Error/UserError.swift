//
//  UserError.swift
//  FixIt
//
//  Created by Josiah Agosto on 12/23/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation

enum UserError: Error {
    case UpdatingValues
}



extension UserError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .UpdatingValues:
            return NSLocalizedString("Error updating values, please try again later", comment: "")
        }
    }
}
