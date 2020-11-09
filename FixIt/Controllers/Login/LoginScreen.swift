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
    // References / Properties
    public lazy var loginView = LoginView()
    // Variables
    private lazy var customerHome = CustomerViewController()
    private lazy var employeeHome = EmployeeViewController()
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        view = loginView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Setup
    private func setup() {
        // View
        navigationController?.navigationBar.topItem?.titleView = loginView.loginLabel
        // Actions
        loginView.loginButton.addTarget(self, action: #selector(loggingIn(sender:)), for: .touchUpInside)
        loginView.signUpButton.addTarget(self, action: #selector(signUpButtonAction(sender:)), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc private func signUpButtonAction(sender: UIButton) {
        let signUpSheet = SignUpController()
        navigationController?.show(signUpSheet, sender: self)
    }
    
    
    @objc private func loggingIn(sender: UIButton) {
        guard let email = loginView.emailField.text, let password = loginView.passwordField.text else {
            // TODO: This doesn't show when entering wrong login.
            loginView.errorLabel.isHidden = false
            loginView.errorLabel.text = ValidationError.InvalidLoginInput.errorDescription
            return
        }
        signingIn(with: email, and: password)
        sender.isEnabled = false
        sender.isOpaque = true
    } // Func End
    
    // MARK: - Functions
    private func signingIn(with email: String, and password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (_, error) in
            guard let userId = Auth.auth().currentUser?.uid else { print(ValidationError.RetrievingUser.errorDescription!); return }
            if error != nil {
                self.errorSigningIn()
            } else {
                self.successSigningIn(userId: userId)
            } // Else End
        } // Sign In End
    }
    
    
    private func errorSigningIn() {
        self.loginView.errorLabel.isHidden = false
        self.loginView.errorLabel.text = ValidationError.SigningIn.errorDescription
        Constants.shared.loggedIn = false
        DataRetriever().saveSetting(for: Constants.shared.loggedIn, forKey: "logInKey")
    }
    
    
    private func successSigningIn(userId: String) {
        DataRetriever().retrieveUserDataToGet(id: userId, data: .isCustomer) { (isCustomer, _) in
            guard let isCustomer = isCustomer else { return }
            Constants.shared.loggedIn = true
            self.loginView.errorLabel.isHidden = true
            switch isCustomer {
            case true:
                DataRetriever().saveSetting(for: Constants.shared.loggedIn, forKey: "logInKey")
                self.navigationController?.show(self.customerHome, sender: nil)
            case false:
                DataRetriever().saveSetting(for: Constants.shared.loggedIn, forKey: "logInKey")
                self.navigationController?.show(self.employeeHome, sender: nil)
            }
        } // Data Retriever End
    }

} // Class End
