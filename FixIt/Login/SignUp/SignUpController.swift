//
//  SignUpView.swift
//  FixIt
//
//  Created by Josiah Agosto on 10/31/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import UIKit
import Firebase

class SignUpController: UIViewController, UserLocationProtocol, LocationNameProtocol {
// MARK: - Constants
    // Empty View
    private let emptyView = UIView(frame: CGRect.zero)
    // Sign Up Label
    private let signUpLabel = UILabel(frame: CGRect.zero)
    // Name
    private let nameField = UITextField(frame: CGRect.zero)
    // Email
    private let emailField = UITextField(frame: CGRect.zero)
    // Password
    private let passwordField = UITextField(frame: CGRect.zero)
    // City
    private let cityField = UIButton(frame: CGRect.zero)
    // Optional Employee Main Skill
    private let employeeSkill = UITextField(frame: CGRect.zero)
    // Error Label
    private let errorLabel = UILabel(frame: CGRect.zero)
    // Switch Label
    private let employeeSwitchLabel = UILabel(frame: CGRect.zero)
    // Switch to Employee
    let employeeSwitch = UISwitch(frame: CGRect.zero)
    // Account Holder Button
    let accountHolderButton = UIButton(frame: CGRect.zero)
    // Login Button
    private let registerButton = UIButton(frame: CGRect.zero)
    // Variables
    lazy var customerHome = Home()
    lazy var employeeHome = EmployeeHome()
    private var localIsCustomer: Bool = true
    var userLocationName: String? = ""
    var userState: String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupConstraints()
    }
    
// MARK: - Large UI Setup
    private func setup() {
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)
        // Label
        signUpLabel.text = "Register"
        signUpLabel.textAlignment = NSTextAlignment.center
        signUpLabel.backgroundColor = UIColor.clear
        signUpLabel.font = UIFont(name: "Avenir", size: 30)
        signUpLabel.translatesAutoresizingMaskIntoConstraints = false
        // Empty View
        emptyView.backgroundColor = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 0.9)
        emptyView.layer.cornerRadius = 10
        emptyView.layer.borderColor = UIColor.gray.cgColor
        emptyView.layer.borderWidth = 1
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        // Name
        nameField.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 88/255, green: 88/255, blue: 88/255, alpha: 1.0)])
        nameField.layer.cornerRadius = 10
        nameField.layer.shadowColor = UIColor.black.cgColor
        nameField.layer.shadowOffset = CGSize(width: 5, height: 1)
        nameField.layer.shadowRadius = 90
        nameField.layer.shadowOpacity = 0.5
        nameField.layer.masksToBounds = false
        nameField.backgroundColor = UIColor.clear
        nameField.autocorrectionType = UITextAutocorrectionType.no
        nameField.translatesAutoresizingMaskIntoConstraints = false
        // Email
        emailField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 88/255, green: 88/255, blue: 88/255, alpha: 1.0)])
        emailField.layer.cornerRadius = 10
        emailField.layer.shadowColor = UIColor.black.cgColor
        emailField.layer.shadowOffset = CGSize(width: 5, height: 1)
        emailField.layer.shadowRadius = 90
        emailField.layer.shadowOpacity = 0.5
        emailField.layer.masksToBounds = false
        emailField.backgroundColor = UIColor.clear
        emailField.autocorrectionType = UITextAutocorrectionType.no
        emailField.translatesAutoresizingMaskIntoConstraints = false
        // Password
        passwordField.attributedPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 88/255, green: 88/255, blue: 88/255, alpha: 1.0)])
        passwordField.layer.cornerRadius = 10
        passwordField.layer.shadowColor = UIColor.black.cgColor
        passwordField.layer.shadowOffset = CGSize(width: 5, height: 1)
        passwordField.layer.shadowRadius = 90
        passwordField.layer.shadowOpacity = 0.5
        passwordField.layer.masksToBounds = false
        passwordField.isSecureTextEntry = true
        passwordField.textContentType = .newPassword
        passwordField.backgroundColor = UIColor.clear
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        // City
        cityField.setTitle("Your Location: \(userLocationName ?? "Unable to find Location")", for: .normal)
        cityField.layer.cornerRadius = 10
        cityField.layer.shadowColor = UIColor.black.cgColor
        cityField.layer.shadowOffset = CGSize(width: 5, height: 1)
        cityField.layer.shadowRadius = 90
        cityField.layer.shadowOpacity = 0.5
        cityField.backgroundColor = UIColor.clear
        cityField.setTitleColor(UIColor(red: 88/255, green: 88/255, blue: 88/255, alpha: 1.0), for: .normal)
        cityField.layer.masksToBounds = true
        cityField.contentHorizontalAlignment = .left
        cityField.translatesAutoresizingMaskIntoConstraints = false
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
        employeeSkill.autocorrectionType = UITextAutocorrectionType.no
        employeeSkill.translatesAutoresizingMaskIntoConstraints = false
        // Employee Switch
        employeeSwitch.isOn = false
        employeeSwitch.onTintColor = UIColor.black
        employeeSwitch.translatesAutoresizingMaskIntoConstraints = false
        // Employee Switch Label
        employeeSwitchLabel.text = "Employee Sign Up:"
        employeeSwitchLabel.textColor = UIColor(red: 88/255, green: 88/255, blue: 88/255, alpha: 1.0)
        employeeSwitchLabel.backgroundColor = UIColor.clear
        employeeSwitchLabel.textAlignment = NSTextAlignment.left
        employeeSwitchLabel.translatesAutoresizingMaskIntoConstraints = false
        // Error Label
        errorLabel.text = "Error signing in, check Email and Password and Try Again."
        errorLabel.backgroundColor = UIColor.clear
        errorLabel.numberOfLines = 2
        errorLabel.adjustsFontSizeToFitWidth = true
        errorLabel.textColor = UIColor.red
        errorLabel.font = UIFont.systemFont(ofSize: 13)
        errorLabel.isHidden = true
        errorLabel.textAlignment = NSTextAlignment.center
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        // Account Holder
        accountHolderButton.setTitle("Already have an account? Sign In", for: .normal)
        accountHolderButton.backgroundColor = UIColor.clear
        accountHolderButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        accountHolderButton.setTitleColor(UIColor.red, for: .normal)
        accountHolderButton.translatesAutoresizingMaskIntoConstraints = false
        // Register Button
        registerButton.setTitleColor(UIColor.white, for: .normal)
        registerButton.setTitle("Register", for: .normal)
        registerButton.layer.cornerRadius = 20
        registerButton.backgroundColor = UIColor(red: 77/255, green: 130/255, blue: 199/255, alpha: 1.0)
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        // Actions
        registerButton.addTarget(self, action: #selector(createSpecifiedUser(sender:)), for: .touchUpInside)
        employeeSwitch.addTarget(self, action: #selector(signedInWithEmployee(sender:)), for: .valueChanged)
        cityField.addTarget(self, action: #selector(showMapView(sender:)), for: .touchUpInside)
        accountHolderButton.addTarget(self, action: #selector(accountHolderAction(sender:)), for: .touchUpInside)
        // Subviews
        self.view.addSubview(emptyView)
        emptyView.addSubview(nameField)
        emptyView.addSubview(emailField)
        emptyView.addSubview(passwordField)
        emptyView.addSubview(cityField)
        emptyView.addSubview(employeeSkill)
        self.view.addSubview(signUpLabel)
        self.view.addSubview(employeeSwitch)
        self.view.addSubview(errorLabel)
        self.view.addSubview(accountHolderButton)
        self.view.addSubview(registerButton)
        self.view.addSubview(employeeSwitchLabel)
    }
    
//MARK: - Delegate Functions
    // User Location Delegate Functions
    func getLocationName(location: String) {
        userLocationName = location
    }
    
    
    func getUserState(location: String) {
        userState = location
    }
    
    // Location Name Delegate Functions
    func userEnteredLocation(forString: String) {
        cityField.setTitle(forString, for: .normal)
        print("New Location Set")
    }
// MARK: - Actions
    // Employee Sign in or Not
    @objc private func signedInWithEmployee(sender: UISwitch) {
        switch sender.isOn {
        case true:
            isCustomer = false
            localIsCustomer = false
            self.errorLabel.isHidden = true
            self.employeeSkill.isHidden = false
        case false:
            print("Is False")
            isCustomer = true
            localIsCustomer = true
            self.errorLabel.isHidden = true
            self.employeeSkill.isHidden = true
        }
    }
    
// MARK: Firebase Authentication
    @objc private func createSpecifiedUser(sender: UIButton) {
        createUser()
    } // createSpecificUser Func End
    
// MARK: - Map View Action
    @objc private func showMapView(sender: UIButton) {
        let placesController = PlacesSearchController()
        self.navigationController?.present(placesController, animated: true)
    }
    
// MARK: - Account Holder Action
    @objc private func accountHolderAction(sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
//MARK: - Functions
    private func createAtSignUpDate() -> String {
        let signUpDate = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .long
        formatter.string(from: signUpDate)
        return formatter.string(from: signUpDate)
    }
    
    
    private func createUser() {
        guard let email = emailField.text, let password = passwordField.text, let name = nameField.text, let location = userLocationName, let skill = employeeSkill.text, let state = userState else {
            errorLabel.isHidden = false
            errorLabel.text = "Invalid Form"
            loggedIn = false
            print("Invalid Text")
            return
        }
        // Create User
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            guard let uid = Auth.auth().currentUser?.uid else { print("Error getting User Id"); return }
            switch self.localIsCustomer {
            case true:
                // Customer
                isCustomer = true
                let customerReference = dbReference.child("Users").child("byId").child(uid)
                let customerValues = ["name": name, "email": email, "location": location, "state": state, "signedUp": self.createAtSignUpDate(), "isCustomer": self.localIsCustomer] as [String : Any]
                customerReference.updateChildValues(customerValues) { (error, _) in
                    if error != nil {
                        self.errorLabel.isHidden = false
                        self.errorLabel.text = "Error indexing values"
                    }
                    loggedIn = true
                    DataRetriever().saveSetting()
                    print("New Data: \(self.localIsCustomer)")
                    self.navigationController?.show(self.customerHome, sender: self)
                }
            case false:
                // Employee
                isCustomer = false
                let employeeReference = dbReference.child("Users").child("byId").child(uid)
                let employeeValues = ["name": name, "email": email, "location": location, "skill": skill, "state": state, "signedUp": self.createAtSignUpDate(), "isCustomer": self.localIsCustomer] as [String : Any]
                employeeReference.updateChildValues(employeeValues) { (error, _) in
                    if error != nil {
                        self.errorLabel.isHidden = false
                        self.errorLabel.text = "Error indexing values"
                    }
                    loggedIn = true
                    DataRetriever().saveSetting()
                    print("New Data 2: \(self.localIsCustomer)")
                    self.navigationController?.show(self.employeeHome, sender: self)
                }
            }
        } // Auth End
    } // Func End
} // Class End


// MARK: - Constraints Extension
extension SignUpController {
    private func setupConstraints() {
        // Empty View
        emptyView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emptyView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -75).isActive = true
        emptyView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        emptyView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        emptyView.heightAnchor.constraint(equalToConstant: 320).isActive = true
        // Sign Up Label
        signUpLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 40).isActive = true
        signUpLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        signUpLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        signUpLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        // Name Field
        nameField.topAnchor.constraint(equalTo: emptyView.topAnchor, constant: 10).isActive = true
        nameField.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        nameField.widthAnchor.constraint(equalTo: emptyView.widthAnchor, constant: -20).isActive = true
        nameField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        // Email Field
        emailField.topAnchor.constraint(equalTo: emptyView.topAnchor, constant: 70).isActive = true
        emailField.widthAnchor.constraint(equalTo: emptyView.widthAnchor, constant: -20).isActive = true
        emailField.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        emailField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        // Password Field
        passwordField.topAnchor.constraint(equalTo: emptyView.topAnchor, constant: 130).isActive = true
        passwordField.widthAnchor.constraint(equalTo: emptyView.widthAnchor, constant: -20).isActive = true
        passwordField.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        passwordField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        // City Field
        cityField.topAnchor.constraint(equalTo: emptyView.topAnchor, constant: 190).isActive = true
        cityField.widthAnchor.constraint(equalTo: emptyView.widthAnchor, constant: -20).isActive = true
        cityField.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        cityField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        // Employee Skill
        employeeSkill.topAnchor.constraint(equalTo: emptyView.topAnchor, constant: 250).isActive = true
        employeeSkill.widthAnchor.constraint(equalTo: emptyView.widthAnchor, constant: -20).isActive = true
        employeeSkill.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        employeeSkill.heightAnchor.constraint(equalToConstant: 40).isActive = true
        // Employee Switch
        employeeSwitch.topAnchor.constraint(equalTo: emptyView.bottomAnchor, constant: 20).isActive = true
        employeeSwitch.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        employeeSwitch.widthAnchor.constraint(equalToConstant: 60).isActive = true
        employeeSwitch.heightAnchor.constraint(equalToConstant: 30).isActive = true
        // Employee Switch Label
        employeeSwitchLabel.topAnchor.constraint(equalTo: emptyView.bottomAnchor, constant: 20).isActive = true
        employeeSwitchLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        employeeSwitchLabel.trailingAnchor.constraint(equalTo: employeeSwitch.leadingAnchor).isActive = true
        employeeSwitchLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        // Error Label
        errorLabel.bottomAnchor.constraint(equalTo: accountHolderButton.topAnchor, constant: -5).isActive = true
        errorLabel.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20).isActive = true
        errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        errorLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
        // Account Holder Button
        accountHolderButton.bottomAnchor.constraint(equalTo: registerButton.topAnchor, constant: -10).isActive = true
        accountHolderButton.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        accountHolderButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        accountHolderButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        // Register Button
        registerButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        registerButton.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -20).isActive = true
        registerButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}
