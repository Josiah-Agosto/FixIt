//
//  LoginView.swift
//  FixIt
//
//  Created by Josiah Agosto on 5/20/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import UIKit

class LoginView: UIView {
    // Properties / References
    // Login
    public lazy var loginLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.sizeToFit()
        label.text = "Log In"
        label.backgroundColor = UIColor.clear
        label.font = UIFont(name: "AvenirNext-Medium", size: 20)
        label.textColor = UIColor(red: 20 / 255, green: 20 / 255, blue: 20 / 255, alpha: 1.0)
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    // Authentication Container
    public lazy var authenticationContainer: UIView = {
        let container = UIView(frame: .zero)
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = UIColor.clear
        return container
    }()
    // Email
    public lazy var emailField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        let customPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 20 / 255, green: 20 / 255, blue: 20 / 255, alpha: 0.7)])
        textField.attributedPlaceholder = customPlaceholder
        textField.backgroundColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1.0)
        textField.textColor = UIColor.black
        textField.layer.cornerRadius = 5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        textField.autocorrectionType = .no
        let emailEmptyView = UIView()
        emailEmptyView.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
        textField.leftViewMode = .always
        textField.leftView = emailEmptyView
        return textField
    }()
    // Password
    public lazy var passwordField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.translatesAutoresizingMaskIntoConstraints = false
        let customPlaceholder = NSAttributedString(string: "Password", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 20 / 255, green: 20 / 255, blue: 20 / 255, alpha: 0.7)])
        textField.attributedPlaceholder = customPlaceholder
        textField.backgroundColor = UIColor(red: 210/255, green: 210/255, blue: 210/255, alpha: 1.0)
        textField.textColor = UIColor.black
        textField.layer.cornerRadius = 5
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        textField.autocorrectionType = .no
        textField.isSecureTextEntry = true
        textField.textContentType = .none
        let passwordEmptyView = UIView()
        passwordEmptyView.frame = CGRect(x: 0, y: 0, width: 10, height: 10)
        textField.leftViewMode = .always
        textField.leftView = passwordEmptyView
        return textField
    }()
    // Sign Up Button
    public lazy var signUpButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Don't have an Account? Sign Up", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        button.setTitleColor(UIColor(red: 203/255, green: 72/255, blue: 72/255, alpha: 1.0), for: .normal)
        return button
    }()
    // Error Label
    public lazy var errorLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Error signing in, please Try Again."
        label.backgroundColor = UIColor.clear
        label.numberOfLines = 0
        label.textColor = UIColor.red
        label.font = UIFont.systemFont(ofSize: 13)
        label.isHidden = true
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    // Login Button
    public lazy var loginButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitle("Login", for: .normal)
        button.backgroundColor = UIColor(red: 77/255, green: 130/255, blue: 199/255, alpha: 1.0)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        return button
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    
    private func setup() {
        // View
        backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)
        // Delegates
        emailField.delegate = TextFieldDelegate.shared
        passwordField.delegate = TextFieldDelegate.shared
        // Subviews
        authenticationContainer.addSubview(emailField)
        authenticationContainer.addSubview(passwordField)
        authenticationContainer.addSubview(signUpButton)
        addSubview(authenticationContainer)
        addSubview(errorLabel)
        addSubview(loginButton)
        // Constraints
        constraints()
    }
    
    
    private func constraints() {
        // TODO: Fix all these messy constraints
        authenticationContainer.topAnchor.constraint(equalTo: topAnchor, constant: 150).isActive = true
        authenticationContainer.widthAnchor.constraint(equalTo: widthAnchor, constant: -100).isActive = true
        authenticationContainer.heightAnchor.constraint(equalToConstant: 150).isActive = true
        authenticationContainer.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        // Email
        emailField.topAnchor.constraint(equalTo: authenticationContainer.topAnchor, constant: 5).isActive = true
        emailField.widthAnchor.constraint(equalTo: authenticationContainer.widthAnchor, constant: -10).isActive = true
        emailField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        emailField.centerXAnchor.constraint(equalTo: authenticationContainer.centerXAnchor).isActive = true
        // Password
        passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 10).isActive = true
        passwordField.widthAnchor.constraint(equalTo: authenticationContainer.widthAnchor, constant: -10).isActive = true
        passwordField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        passwordField.centerXAnchor.constraint(equalTo: authenticationContainer.centerXAnchor).isActive = true
        // Sign Up
        signUpButton.topAnchor.constraint(equalTo: passwordField.bottomAnchor, constant: 10).isActive = true
        signUpButton.widthAnchor.constraint(equalTo: authenticationContainer.widthAnchor).isActive = true //
        signUpButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        signUpButton.centerXAnchor.constraint(equalTo: authenticationContainer.centerXAnchor).isActive = true
        // Error Label
        errorLabel.bottomAnchor.constraint(equalTo: loginButton.topAnchor, constant: -15).isActive = true
        errorLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -30).isActive = true
        errorLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        // Login Button
        loginButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
        loginButton.widthAnchor.constraint(equalTo: widthAnchor, constant: -30).isActive = true
        loginButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
