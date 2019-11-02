//
//  LoginScreen.swift
//  FixIt
//
//  Created by Josiah Agosto on 10/31/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import UIKit
import Firebase

class LoginScreen: UIViewController {
    // Label
//    private let loginLabel = UILabel(frame: CGRect(x: UIScreen.main.bounds.width / 2 - 55, y: 50, width: 110, height: 30))
    // Email
    private let emailField = UITextField(frame: CGRect(x: UIScreen.main.bounds.width / 2 - 125, y: 150, width: 250, height: 30))
    // Password
    private let passwordField = UITextField(frame: CGRect(x: UIScreen.main.bounds.width / 2 - 125, y: 195, width: 250, height: 30))
    // Sign Up Button
    private let signUpButton = UIButton(frame: CGRect(x: UIScreen.main.bounds.width / 2 - 50, y: 230, width: 100, height: 20))
    // Error Label
    private let errorLabel = UILabel(frame: CGRect(x: 0, y: UIScreen.main.bounds.height - 220, width: UIScreen.main.bounds.width, height: 20))
    // Login Button
    private let loginButton = UIButton(frame: CGRect(x: UIScreen.main.bounds.width / 2 - 125, y: 265, width: UIScreen.main.bounds.width, height: 45))
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        checkForLoggedIn()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
    private func setup() {
        self.view.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)
        // Navigation Bar
        self.title = "Sign In"
        // Login Button
        loginButton.setTitleColor(UIColor.white, for: .normal)
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = UIColor(red: 77/255, green: 130/255, blue: 199/255, alpha: 1.0)
        loginButton.layer.cornerRadius = 10
        // Email Field
        emailField.placeholder = "Email"
        emailField.backgroundColor = UIColor.white
        emailField.textColor = UIColor.black
        emailField.layer.cornerRadius = 5
        // Password Field
        passwordField.placeholder = "Password"
        passwordField.backgroundColor = UIColor.white
        passwordField.textColor = UIColor.black
        passwordField.layer.cornerRadius = 5
        // Sign Up Button
        signUpButton.setTitle("Sign Up", for: .normal)
        signUpButton.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        signUpButton.setTitleColor(UIColor(red: 203/255, green: 72/255, blue: 72/255, alpha: 1.0), for: .normal)
        // Error Label
        errorLabel.text = "Error signing in, please Try Again."
        errorLabel.backgroundColor = UIColor.clear
        errorLabel.numberOfLines = 2
        errorLabel.textColor = UIColor.red
        errorLabel.font = UIFont.systemFont(ofSize: 13)
        errorLabel.isHidden = true
        errorLabel.textAlignment = NSTextAlignment.center
        // Actions
        loginButton.addTarget(self, action: #selector(loggingIn(sender:)), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUpButtonAction(sender:)), for: .touchUpInside)
        // Adding to Subview
//        self.view.addSubview(loginLabel)
        self.view.addSubview(emailField)
        self.view.addSubview(passwordField)
        self.view.addSubview(signUpButton)
        self.view.addSubview(loginButton)
    }
    
    
    @objc func signUpButtonAction(sender: UIButton) {
        let signUpSheet = SignUpController()
        self.present(signUpSheet, animated: true)
    }
    
    
    @objc func loggingIn(sender: UIButton) {
        guard let email = emailField.text, let password = passwordField.text else {
            errorLabel.text = "Invalid Inputs"
            return
        }
        // Logging In
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                self.errorLabel.text = error?.localizedDescription
            } else {
                let home = Home()
                self.navigationController?.pushViewController(home, animated: true)
            }
        }
    }
    
    
    func checkForLoggedIn() {
        let log = defaults.bool(forKey: "logInKey")
        if log {
            print(loggedIn)
            let home  = Home()
            self.navigationController?.pushViewController(home, animated: true)
        }
    }
    
}
