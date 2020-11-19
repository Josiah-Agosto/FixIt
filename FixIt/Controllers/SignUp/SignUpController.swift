//
//  SignUpController.swift
//  FixIt
//
//  Created by Josiah Agosto on 10/31/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation

class SignUpController: UIViewController, LocationManagerProtocol {
    // References / Properties
    public lazy var signUpView = SignUpView()
    private lazy var locationManager = LocationManager.shared
    private lazy var customerHome = CustomerViewController()
    private lazy var employeeHome = EmployeeViewController()
    private let globalHelper = GlobalHelper.shared
    private let locationHelper = LocationHelperClass()
    private var localIsCustomer: Bool = true
    // Protocol Properties
    var usersLocation: String = ""
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        view = signUpView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        locationManager.startLocating()
        locationManager.locationSetup()
    }
    
    
    private func setup() {
        title = "Sign Up"
        navigationItem.hidesBackButton = true
        navigationItem.leftBarButtonItem = signUpView.cancelBackButton
        signUpView.registerButton.addTarget(self, action: #selector(createSpecifiedUser(sender:)), for: .touchUpInside)
        signUpView.employeeSwitch.addTarget(self, action: #selector(signedInWithEmployee(sender:)), for: .valueChanged)
        signUpView.cityField.addTarget(self, action: #selector(showMapView(sender:)), for: .touchUpInside)
        signUpView.accountHolderButton.addTarget(self, action: #selector(accountHolderAction(sender:)), for: .touchUpInside)
        signUpView.cancelBackButton.target = self
        signUpView.cancelBackButton.action = #selector(goBackToMainScreen(sender:))
        // Delegates
        locationManager.locationManagerDelegate = self
        // Error controller delegate
    }
    

    func userEnteredLocation(forString: String) {
        if signUpView.isExpanded {
            signUpView.cityField.setTitle(forString, for: .normal)
        }
    }
    
    // MARK: - Actions
    @objc private func signedInWithEmployee(sender: UISwitch) {
        signUpView.isExpanded = !sender.isOn
        switch sender.isOn {
        case true:
            Constants.shared.isCustomer = false
            signUpView.cityField.isEnabled = true
            signUpView.cityField.isHidden = false
            signUpView.employeeSkill.isEnabled = true
            signUpView.employeeSkill.isHidden = false
        case false:
            Constants.shared.isCustomer = true
            signUpView.cityField.isEnabled = false
            signUpView.cityField.isHidden = true
            signUpView.employeeSkill.isEnabled = false
            signUpView.employeeSkill.isHidden = true
        }
    }
    
    
    @objc private func createSpecifiedUser(sender: UIButton) {
        createUser()
    }
    

    @objc private func showMapView(sender: UIButton) {
        let placesController = PlacesSearchController()
        self.navigationController?.present(placesController, animated: true)
    }
    

    @objc private func accountHolderAction(sender: UIButton) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    @objc private func goBackToMainScreen(sender: UIBarButtonItem) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    // MARK: - Private Functions
    private func createAtSignUpDate() -> String {
        let signUpDate = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .medium
        formatter.dateStyle = .long
        formatter.string(from: signUpDate)
        return formatter.string(from: signUpDate)
    }
    
    // TODO: Put Auth error in global helper.
    
    private func createUser() {
        guard let email = signUpView.emailField.text, let password = signUpView.passwordField.text, let name = signUpView.nameField.text, let skill = signUpView.employeeSkill.text, let state = locationHelper.userState else {
            // TODO: Add error controller here
            self.globalHelper.globalError(with: "Sign Up Error", and: "All fields must be filled in.") { (controller) in
                DispatchQueue.main.async {
                    self.present(controller, animated: true, completion: nil)
                }
            }
            errorOccurred()
            return
        }
        // Create User
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            guard let uid = Auth.auth().currentUser?.uid else { print(ValidationError.RetrievingUser.errorDescription!); return }
            if let error = error {
                self.globalHelper.globalError(with: "Error Creating User", and: error.localizedDescription) { (alertController) in
                    DispatchQueue.main.async {
                        self.present(alertController, animated: true, completion: nil)
                    }
                }
                self.errorOccurred()
            } else {
                switch self.localIsCustomer {
                case true:
                    print("Location: \(self.usersLocation)")
                    // Customer
                    self.createCustomer(with: uid, with: name, with: email, and: self.usersLocation)
                case false:
                    // Employee
                    self.createEmployee(with: uid, with: name, with: email, with: self.usersLocation, with: skill, and: state)
                } // Switch End
            }
        } // Auth End
    } // Func End
    
    
    private func createCustomer(with uid: String, with name: String, with email: String, and location: String?) {
        Constants.shared.isCustomer = true
        let customerReference = Constants.shared.dbReference.child("Users").child("byId").child(uid)
        let customerValues = ["name": name, "email": email.convertForbiddenFirebaseSymbols(from: email), "signedUp": self.createAtSignUpDate(), "isCustomer": self.localIsCustomer, "issueCounter": 0, "location": location ?? "Not Available"] as [String : Any]
        customerReference.updateChildValues(customerValues) { (error, _) in
            if error != nil {
                self.globalHelper.globalError(with: "Error Creating User", and: error!.localizedDescription) { (alertController) in
                    DispatchQueue.main.async {
                        self.present(alertController, animated: true, completion: nil)
                    }
                }
                self.errorOccurred()
            } else {
                Constants.shared.loggedIn = true
                DataRetriever().saveSetting(for: Constants.shared.loggedIn, forKey: "logInKey")
                self.navigationController?.show(self.customerHome, sender: self)
            }
        }
    }
    
    
    private func createEmployee(with uid: String, with name: String, with email: String, with location: String, with skill: String, and state: String) {
        Constants.shared.isCustomer = false
        let employeeReference = Constants.shared.dbReference.child("Users").child("byId").child(uid)
        let employeeValues = ["name": name, "email": email.convertForbiddenFirebaseSymbols(from: email), "location": location, "skill": skill, "state": state, "signedUp": self.createAtSignUpDate(), "isCustomer": self.localIsCustomer] as [String : Any]
        employeeReference.updateChildValues(employeeValues) { (error, _) in
            if error != nil {
                self.globalHelper.globalError(with: "Error Creating User", and: error!.localizedDescription) { (alertController) in
                    DispatchQueue.main.async {
                        self.present(alertController, animated: true, completion: nil)
                    }
                }
                self.errorOccurred()
            } else {
                Constants.shared.loggedIn = true
                DataRetriever().saveSetting(for: Constants.shared.loggedIn, forKey: "logInKey")
                self.navigationController?.show(self.employeeHome, sender: self)
            }
        }
    }
    
    
    private func errorOccurred() {
        self.signUpView.errorLabel.isHidden = false
        self.signUpView.errorLabel.text = UserError.UpdatingValues.errorDescription
        Constants.shared.loggedIn = false
        DataRetriever().saveSetting(for: Constants.shared.loggedIn, forKey: "logInKey")
    }
} // Class End


// MARK: - Location Error Delegate
extension SignUpController: ErrorControllerProtocol {
    func locationErrorController(with title: String, and description: String) {
        locationHelper.locationRequestError(with: title, and: description) { (controller) in
            DispatchQueue.main.async {
                self.present(controller, animated: true)
            }
        }
    }
}
