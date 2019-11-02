//
//  EmployeeLogin.swift
//  FixIt
//
//  Created by Josiah Agosto on 10/31/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import UIKit

class EmployeeLogin: UIView {
    // TextFields
    let emailField = UITextField(frame: CGRect(x: UIScreen.main.bounds.width / 2 - 150, y: 200, width: 300, height: 40))
    let passwordField = UITextField(frame: CGRect(x: UIScreen.main.bounds.width / 2 - 150, y: 260, width: 300, height: 40))

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    
    private func setup() {
        backgroundColor = UIColor.clear
        // Extra stuff for UI
        emailField.backgroundColor = UIColor.white
        emailField.layer.cornerRadius = 5
        emailField.textColor = UIColor.black
        emailField.placeholder = "Email"
        passwordField.backgroundColor = UIColor.white
        passwordField.layer.cornerRadius = 5
        passwordField.textColor = UIColor.black
        passwordField.placeholder = "Password"
        // Adding to Subview
        addSubview(emailField)
        addSubview(passwordField)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
