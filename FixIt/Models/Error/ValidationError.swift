//
//  ValidationError.swift
//  FixIt
//
//  Created by Josiah Agosto on 12/23/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation

enum ValidationError: Error {
    case InvalidLoginInput
    case RetrievingUser
    case SigningIn
    case RetrievingData
    case CreatingUser
}



extension ValidationError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .InvalidLoginInput:
            return NSLocalizedString("The Username or Password are incorrect", comment: "")
        case .RetrievingUser:
            return NSLocalizedString("An error occurred getting the User", comment: "")
        case .SigningIn:
            return NSLocalizedString("An error occurred Signing In", comment: "")
        case .RetrievingData:
            return NSLocalizedString("Error retrieving data from database", comment: "")
        case .CreatingUser:
            return NSLocalizedString("Unable to create user at this time", comment: "")
        }
    }
}
