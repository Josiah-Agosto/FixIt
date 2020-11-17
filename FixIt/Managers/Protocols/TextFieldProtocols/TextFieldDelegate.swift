//
//  TextFieldDelegate.swift
//  FixIt
//
//  Created by Josiah Agosto on 5/27/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

class TextFieldDelegate: NSObject, UITextFieldDelegate {
    // MARK: - References / Properties
    static let shared = TextFieldDelegate()
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

}
