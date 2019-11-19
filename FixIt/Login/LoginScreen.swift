//
//  LoginScreen.swift
//  FixIt
//
//  Created by Josiah Agosto on 10/31/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import UIKit
import Firebase
import CoreLocation

// TODO: - Add Geofence and fix Label issues from isCustomer.

class LoginScreen: UIViewController {
    // Login Label
    private let loginLabel = UILabel(frame: CGRect.zero)
    // Email
    private let emailField = UITextField(frame: CGRect.zero)
    // Password
    private let passwordField = UITextField(frame: CGRect.zero)
    // Sign Up Button
    private let signUpButton = UIButton(frame: CGRect.zero)
    // Error Label
    private let errorLabel = UILabel(frame: CGRect.zero)
    // Login Button
    private let loginButton = UIButton(frame: CGRect.zero)
    // Location Manager
    private let locationManager = CLLocationManager()
    var delegate: UserLocationDelegate?
    var userTownAndState: String = ""
    var userState: String = ""
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setupLocationManager()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        checkForLoggedIn()
        setup()
        setupConstraints()
    }
    
// MARK: - Setup
    private func setup() {
        self.navigationController?.isNavigationBarHidden = true
        self.view.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)
        // Login Label
        loginLabel.text = "Log In"
        loginLabel.backgroundColor = UIColor.clear
        loginLabel.font = UIFont(name: "Avenir", size: 30)
        loginLabel.textAlignment = NSTextAlignment.center
        loginLabel.translatesAutoresizingMaskIntoConstraints = false
        // Login Button
        loginButton.setTitleColor(UIColor.white, for: .normal)
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = UIColor(red: 77/255, green: 130/255, blue: 199/255, alpha: 1.0)
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.layer.cornerRadius = 10
        // Email Field
        emailField.placeholder = "Email"
        emailField.backgroundColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1.0)
        emailField.textColor = UIColor.black
        emailField.layer.cornerRadius = 5
        emailField.layer.borderColor = UIColor.lightGray.cgColor
        emailField.layer.borderWidth = 1
        emailField.translatesAutoresizingMaskIntoConstraints = false
        emailField.autocorrectionType = UITextAutocorrectionType.no
        let emailEmptyView = UIView()
        emailEmptyView.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
        emailField.leftViewMode = .always
        emailField.leftView = emailEmptyView
        // Password Field
        passwordField.placeholder = "Password"
        passwordField.backgroundColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1.0)
        passwordField.textColor = UIColor.black
        passwordField.layer.cornerRadius = 5
        passwordField.layer.borderColor = UIColor.lightGray.cgColor
        passwordField.layer.borderWidth = 1
        passwordField.autocorrectionType = UITextAutocorrectionType.no
        passwordField.translatesAutoresizingMaskIntoConstraints = false
        passwordField.isSecureTextEntry = true
        let passwordEmptyView = UIView()
        passwordEmptyView.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
        passwordField.leftViewMode = .always
        passwordField.leftView = passwordEmptyView
        // Sign Up Button
        signUpButton.setTitle("Don't have an Account? Sign Up", for: .normal)
        signUpButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        signUpButton.setTitleColor(UIColor(red: 203/255, green: 72/255, blue: 72/255, alpha: 1.0), for: .normal)
        signUpButton.translatesAutoresizingMaskIntoConstraints = false
        // Error Label
        errorLabel.text = "Error signing in, please Try Again."
        errorLabel.backgroundColor = UIColor.clear
        errorLabel.numberOfLines = 2
        errorLabel.textColor = UIColor.red
        errorLabel.font = UIFont.systemFont(ofSize: 13)
        errorLabel.isHidden = true
        errorLabel.textAlignment = NSTextAlignment.center
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        // Actions
        loginButton.addTarget(self, action: #selector(loggingIn(sender:)), for: .touchUpInside)
        signUpButton.addTarget(self, action: #selector(signUpButtonAction(sender:)), for: .touchUpInside)
        // Adding to Subview
        self.view.addSubview(loginLabel)
        self.view.addSubview(emailField)
        self.view.addSubview(passwordField)
        self.view.addSubview(signUpButton)
        self.view.addSubview(errorLabel)
        self.view.addSubview(loginButton)
    }
    
// MARK: - Actions
    @objc private func signUpButtonAction(sender: UIButton) {
        let signUpSheet = SignUpController()
        delegate = signUpSheet
        delegate?.getLocationName(location: userTownAndState)
        delegate?.getUserState(location: userState)
        self.navigationController?.show(signUpSheet, sender: self)
    }
    
    
    @objc private func loggingIn(sender: UIButton) {
        guard let email = emailField.text, let password = passwordField.text else {
            errorLabel.isHidden = false
            errorLabel.text = "Invalid Inputs"
            return
        }
        // Logging In
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                self.errorLabel.isHidden = false
                self.errorLabel.text = error?.localizedDescription
            } else {
                let home = Home()
                self.errorLabel.isHidden = true
                loggedIn = true
                self.navigationController?.show(home, sender: self)
            } // Else End
        } // Auth End
    } // Func End
    
// MARK: - Functions
    func checkForLoggedIn() {
        let log = defaults.bool(forKey: "logInKey")
        if log {
            print("Logged from checker100 \(loggedIn)")
            self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    
    func setupLocationManager() {
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestAlwaysAuthorization()
            getUserLocationDetails()
        } else {
            let locationDisabledAlertController = UIAlertController(title: "In order for FixIt to work, Location Services need to be Enabled.", message: "To enable go to, Settings > Privacy > Location Services", preferredStyle: .alert)
            locationDisabledAlertController.addAction(UIAlertAction(title: "Go to Settings", style: .default, handler: { (_) in
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    UIApplication.shared.open(settingsUrl, options: [:]) { (success) in
                        print("Opened Settings")
                    }
                }
            }))
            locationDisabledAlertController.addAction(UIAlertAction(title: "No thanks!", style: .cancel, handler: nil))
            present(locationDisabledAlertController, animated: true)
        }
    }
    
    
    func getUserLocationDetails() {
        guard let userLocation = locationManager.location else {
            print("Can't find Location")
            return
        }
        
        findUsersLocationDetails(in: userLocation) { (placemark) in
            guard let placemark = placemark else { print("Error Placemarking"); return }
            
            if let town = placemark.locality {
                self.userTownAndState = ""
                self.userTownAndState = self.userTownAndState + "\(town),"
            }
            if let state = placemark.administrativeArea {
                self.userState = ""
                self.userState = self.userState + "\(state)"
                self.userTownAndState = self.userTownAndState + " \(state)"
            }
            
            
            print("Real Location: \(self.userTownAndState)")
            print("User State: \(self.userState)")
        }
    }
    
    
    private func findUsersLocationDetails(in location: CLLocation, completion: @escaping(CLPlacemark?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            guard error == nil else {
                print("Error grabbing Location")
                completion(nil)
                return
            }
            
            guard let placemark = placemarks?[0] else {
                print("Error finding Placemark")
                completion(nil)
                return
            }
            completion(placemark)
        }
    }
    
// MARK: - Constraints
    private func setupConstraints() {
        // Login Label
        loginLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        loginLabel.widthAnchor.constraint(equalToConstant: 250).isActive = true
        loginLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        loginLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        // Email
        emailField.topAnchor.constraint(equalTo: view.topAnchor, constant: 175).isActive = true
        emailField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        emailField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        emailField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        // Password
        passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 20).isActive = true
        passwordField.widthAnchor.constraint(equalToConstant: 300).isActive = true
        passwordField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        passwordField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        // Sign Up
        signUpButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 10).isActive = true
        signUpButton.widthAnchor.constraint(equalToConstant: 250).isActive = true
        signUpButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        signUpButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        // Login Button
        loginButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -65).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: 265).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 45).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        // Error Label
        errorLabel.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -30).isActive = true
        errorLabel.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        errorLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        errorLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }

} // Class End

// MARK: - Delegate
// Core Location Delegate
extension LoginScreen: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedAlways {
            locationManager.requestLocation()
        } else {
            print("Authorization Changed Error 251")
        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
    }
    
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error retrieving Location: \(error.localizedDescription)")
    }
}
