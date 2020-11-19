//
//  TextFieldDelegate.swift
//  FixIt
//
//  Created by Josiah Agosto on 5/27/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

final class TextFieldDelegate: NSObject, UITextFieldDelegate {
    // MARK: - References / Properties
    static let shared = TextFieldDelegate()
    var forPassword: Bool = false
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if forPassword == true {
            textField.isSecureTextEntry = true
        }
        return true
    }

}
