//
//  LoginTextFieldDelegate.swift
//  FixIt
//
//  Created by Josiah Agosto on 5/27/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

extension LoginView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print("Hi")
        textField.resignFirstResponder()
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == passwordField && !passwordField.isSecureTextEntry {
            print("Called")
            passwordField.isSecureTextEntry = true
        }
        return true
    }
}
