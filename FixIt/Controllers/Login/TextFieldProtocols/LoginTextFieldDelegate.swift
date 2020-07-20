//
//  LoginTextFieldDelegate.swift
//  FixIt
//
//  Created by Josiah Agosto on 5/27/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

class LoginTextFieldDelegate: NSObject, UITextFieldDelegate {
    private var loginView: LoginView
    
    init(loginView: LoginView) {
        self.loginView = loginView
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
