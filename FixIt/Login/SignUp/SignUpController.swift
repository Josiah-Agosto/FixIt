//
//  SignUpView.swift
//  FixIt
//
//  Created by Josiah Agosto on 10/31/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import UIKit
import Firebase

class SignUpController: UIViewController {
    // Sign Up Label
    private let signUpLabel = UILabel(frame: CGRect(x: UIScreen.main.bounds.width / 2 - 50, y: 40, width: 100, height: 30))
    // Name
    private let nameField = UITextField(frame: CGRect(x: UIScreen.main.bounds.width / 2 - 150, y: 120, width: 300, height: 40))
    // Email
    private let emailField = UITextField(frame: CGRect(x: UIScreen.main.bounds.width / 2 - 150, y: 180, width: 300, height: 40))
    // Password
    private let passwordField = UITextField(frame: CGRect(x: UIScreen.main.bounds.width / 2 - 150, y: 240, width: 300, height: 40))
    // Location
    private let locationField = UITextField(frame: CGRect(x: UIScreen.main.bounds.width / 2 - 150, y: 300, width: 300, height: 40))
    // Employee Main Skill
    private let employeeSkill = UITextField(frame: CGRect(x: UIScreen.main.bounds.width / 2 - 150, y: 360, width: 300, height: 40))
    // Error Label
    private let errorLabel = UILabel(frame: CGRect(x: 0, y: UIScreen.main.bounds.height - 220, width: UIScreen.main.bounds.width, height: 20))
    // Switch to Employee
    let employeeSwitch = UISwitch(frame: CGRect(x: UIScreen.main.bounds.width - 72, y: 40, width: 60, height: 30))
    // Login Button
    private let registerButton = UIButton(frame: CGRect(x: UIScreen.main.bounds.width / 2 - 150, y: UIScreen.main.bounds.height - 150, width: 300, height: 65))
    // Variables
    var employeeSignIn: Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
    private func setup() {
        self.view.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)
        // Label
        signUpLabel.text = "Register"
        signUpLabel.font = UIFont.systemFont(ofSize: 25)
        // Name
        nameField.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 88/255, green: 88/255, blue: 88/255, alpha: 1.0)])
        nameField.layer.cornerRadius = 10
        nameField.layer.shadowColor = UIColor.black.cgColor
        nameField.layer.shadowOffset = CGSize(width: 5, height: 1)
        nameField.layer.shadowRadius = 90
        nameField.layer.shadowOpacity = 0.5
        nameField.layer.masksToBounds = false
        nameField.backgroundColor = UIColor.clear
        // UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0)
        // Email
        emailField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 88/255, green: 88/255, blue: 88/255, alpha: 1.0)])
        emailField.layer.cornerRadius = 10
        emailField.layer.shadowColor = UIColor.black.cgColor
        emailField.layer.shadowOffset = CGSize(width: 5, height: 1)
        emailField.layer.shadowRadius = 90
        emailField.layer.shadowOpacity = 0.5
        emailField.layer.masksToBounds = false
        emailField.backgroundColor = UIColor.clear
        // Password
        passwordField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 88/255, green: 88/255, blue: 88/255, alpha: 1.0)])
        passwordField.layer.cornerRadius = 10
        passwordField.layer.shadowColor = UIColor.black.cgColor
        passwordField.layer.shadowOffset = CGSize(width: 5, height: 1)
        passwordField.layer.shadowRadius = 90
        passwordField.layer.shadowOpacity = 0.5
        passwordField.layer.masksToBounds = false
        passwordField.isSecureTextEntry = true
        passwordField.backgroundColor = UIColor.clear
        // Location
        locationField.attributedPlaceholder = NSAttributedString(string: "City, State", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 88/255, green: 88/255, blue: 88/255, alpha: 1.0)])
        locationField.layer.cornerRadius = 10
        locationField.layer.shadowColor = UIColor.black.cgColor
        locationField.layer.shadowOffset = CGSize(width: 5, height: 1)
        locationField.layer.shadowRadius = 90
        locationField.layer.shadowOpacity = 0.5
        locationField.layer.masksToBounds = false
        locationField.backgroundColor = UIColor.clear
        // Employee Skill
        employeeSkill.attributedPlaceholder = NSAttributedString(string: "Main Skill", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 88/255, green: 88/255, blue: 88/255, alpha: 1.0)])
        employeeSkill.layer.cornerRadius = 10
        employeeSkill.layer.shadowColor = UIColor.black.cgColor
        employeeSkill.layer.shadowOffset = CGSize(width: 5, height: 1)
        employeeSkill.layer.shadowRadius = 90
        employeeSkill.layer.shadowOpacity = 0.5
        employeeSkill.layer.masksToBounds = false
        employeeSkill.isHidden = true
        employeeSkill.backgroundColor = UIColor.clear
        // Login Button
        registerButton.setTitleColor(UIColor.white, for: .normal)
        registerButton.setTitle("Register", for: .normal)
        registerButton.backgroundColor = UIColor(red: 77/255, green: 130/255, blue: 199/255, alpha: 1.0)
        registerButton.layer.cornerRadius = 10
        // Employee Switch
        employeeSwitch.isOn = false
        employeeSwitch.onTintColor = UIColor.black
        // Error Label
        errorLabel.text = "Error signing in, check Email and Password and Try Again."
        errorLabel.backgroundColor = UIColor.clear
        errorLabel.numberOfLines = 2
        errorLabel.textColor = UIColor.red
        errorLabel.font = UIFont.systemFont(ofSize: 13)
        errorLabel.isHidden = true
        errorLabel.textAlignment = NSTextAlignment.center
        // Actions
        registerButton.addTarget(self, action: #selector(createSpecifiedUser(sender:)), for: .touchUpInside)
        employeeSwitch.addTarget(self, action: #selector(signedInWithEmployee(sender:)), for: .valueChanged)
        // Subviews
        self.view.addSubview(signUpLabel)
        self.view.addSubview(nameField)
        self.view.addSubview(emailField)
        self.view.addSubview(passwordField)
        self.view.addSubview(locationField)
        self.view.addSubview(employeeSkill)
        self.view.addSubview(employeeSwitch)
        self.view.addSubview(errorLabel)
        self.view.addSubview(registerButton)
    }
    
    // Employee Sign in or Not
    @objc private func signedInWithEmployee(sender: UISwitch) {
        switch sender.isOn {
        case true:
            employeeSignIn = true
            self.errorLabel.isHidden = true
            self.employeeSkill.isHidden = false
        case false:
            employeeSignIn = false
            self.errorLabel.isHidden = true
            self.employeeSkill.isHidden = true
        }
    }
    
    // Authorizing the entered Credentials
    @objc func createSpecifiedUser(sender: UIButton) {
        guard let email = emailField.text, let password = passwordField.text, let name = nameField.text, let location = locationField.text, let skill = employeeSkill.text else {
            errorLabel.isHidden = false
            errorLabel.text = "Invalid Form"
            return
        }
        // Create Users
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            guard let uid = user?.user.uid else { return }
            if error != nil {
                self.errorLabel.isHidden = false
                self.errorLabel.text = "\(error!.localizedDescription)"
            } else {
                if self.employeeSignIn == true {
                    // Employees
                    let employeeReference = dBReference.child("Employees").child(uid)
                    let employeeValues = ["name": name, "email": email, "location": location, "skill": skill]
                    employeeReference.updateChildValues(employeeValues) { (error, reference) in
                        if error != nil {
                            self.errorLabel.isHidden = false
                            self.errorLabel.text = "Error indexing values"
                        }
                        loggedIn = true
                        print(loggedIn)
                        self.saveSetting()
                    }
                } else if self.employeeSignIn == false {
                    // Customers
                    // Customer
                    let customerReference = dBReference.child("Customers").child(uid)
                    let customerValues = ["name": name, "email": email, "location": location]
                    customerReference.updateChildValues(customerValues) { (error, reference) in
                        if error != nil {
                            self.errorLabel.isHidden = false
                            self.errorLabel.text = "Error indexing values"
                        }
                        loggedIn = true
                        print(loggedIn)
                        self.saveSetting()
                    }
                }
                let home = Home()
                self.navigationController?.pushViewController(home, animated: true)
            } // Else End
        } // Auth End
    } // createSpecificUser Func End
    
    // Sets the value set for Bool
    func saveSetting() {
        defaults.set(loggedIn, forKey: "logInKey")
    }
    
}
