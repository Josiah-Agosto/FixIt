//
//  SignUpView.swift
//  FixIt
//
//  Created by Josiah Agosto on 5/20/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import UIKit

class SignUpView: UIView {
    // Properties / References
    public lazy var registerLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.sizeToFit()
        label.text = "Sign Up"
        label.backgroundColor = UIColor.clear
        label.font = UIFont(name: "AvenirNext-Medium", size: 20)
        label.textColor = UIColor(red: 20 / 255, green: 20 / 255, blue: 20 / 255, alpha: 1.0)
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    // Empty View
    public lazy var emptyView: UIView = {
        let view = UIView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 200/255, green: 200/255, blue: 200/255, alpha: 0.9)
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 1
        return view
    }()
    // Name
    public lazy var nameField: UITextField = {
        let nameField = UITextField(frame: .zero)
        nameField.translatesAutoresizingMaskIntoConstraints = false
        nameField.attributedPlaceholder = NSAttributedString(string: "Name", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 88/255, green: 88/255, blue: 88/255, alpha: 1.0)])
        nameField.layer.cornerRadius = 10
        nameField.layer.shadowColor = UIColor.black.cgColor
        nameField.layer.shadowOffset = CGSize(width: 5, height: 1)
        nameField.layer.shadowRadius = 90
        nameField.layer.shadowOpacity = 0.5
        nameField.layer.masksToBounds = false
        nameField.backgroundColor = UIColor.clear
        nameField.autocorrectionType = UITextAutocorrectionType.no
        return nameField
    }()
    // Email
    public lazy var emailField: UITextField = {
        let emailField = UITextField(frame: .zero)
        emailField.translatesAutoresizingMaskIntoConstraints = false
        emailField.attributedPlaceholder = NSAttributedString(string: "Email", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 88/255, green: 88/255, blue: 88/255, alpha: 1.0)])
        emailField.layer.cornerRadius = 10
        emailField.layer.shadowColor = UIColor.black.cgColor
        emailField.layer.shadowOffset = CGSize(width: 5, height: 1)
        emailField.layer.shadowRadius = 90
        emailField.layer.shadowOpacity = 0.5
        emailField.layer.masksToBounds = false
        emailField.backgroundColor = UIColor.clear
        emailField.autocorrectionType = UITextAutocorrectionType.no
        return emailField
    }()
    // Password
    public lazy var passwordField: UITextField = {
        let passwordField = UITextField(frame: .zero)
        passwordField.translatesAutoresizingMaskIntoConstraints = false
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
        return passwordField
    }()
    // City
    public lazy var cityField: UIButton = {
        let cityField = UIButton(frame: .zero)
        cityField.translatesAutoresizingMaskIntoConstraints = false
        cityField.isEnabled = false
        cityField.isHidden = true
        cityField.setTitle("Location", for: .normal)
        cityField.layer.cornerRadius = 10
        cityField.layer.shadowColor = UIColor.black.cgColor
        cityField.layer.shadowOffset = CGSize(width: 5, height: 1)
        cityField.layer.shadowRadius = 90
        cityField.layer.shadowOpacity = 0.5
        cityField.backgroundColor = UIColor.clear
        cityField.setTitleColor(UIColor(red: 88/255, green: 88/255, blue: 88/255, alpha: 1.0), for: .normal)
        cityField.layer.masksToBounds = true
        cityField.contentHorizontalAlignment = .left
        return cityField
    }()
    // Optional Employee Main Skill
    public lazy var employeeSkill: UITextField = {
        let employeeSkill = UITextField(frame: .zero)
        employeeSkill.translatesAutoresizingMaskIntoConstraints = false
        employeeSkill.isEnabled = false
        employeeSkill.isHidden = true
        employeeSkill.attributedPlaceholder = NSAttributedString(string: "Main Skill", attributes: [NSAttributedString.Key.foregroundColor: UIColor(red: 88/255, green: 88/255, blue: 88/255, alpha: 1.0)])
        employeeSkill.layer.cornerRadius = 10
        employeeSkill.layer.shadowColor = UIColor.black.cgColor
        employeeSkill.layer.shadowOffset = CGSize(width: 5, height: 1)
        employeeSkill.layer.shadowRadius = 90
        employeeSkill.layer.shadowOpacity = 0.5
        employeeSkill.layer.masksToBounds = false
        employeeSkill.backgroundColor = UIColor.clear
        employeeSkill.autocorrectionType = UITextAutocorrectionType.no
        return employeeSkill
    }()
    // Switch to Employee
    public lazy var employeeSwitch: UISwitch = {
        let employeeSwitch = UISwitch(frame: .zero)
        employeeSwitch.translatesAutoresizingMaskIntoConstraints = false
        employeeSwitch.isOn = false
        employeeSwitch.onTintColor = UIColor.black
        return employeeSwitch
    }()
    // Switch Label
    public lazy var employeeSwitchLabel: UILabel = {
        let employeeSwitchLabel = UILabel(frame: .zero)
        employeeSwitchLabel.translatesAutoresizingMaskIntoConstraints = false
        employeeSwitchLabel.text = "Employee Sign Up:"
        employeeSwitchLabel.textColor = UIColor(red: 88/255, green: 88/255, blue: 88/255, alpha: 1.0)
        employeeSwitchLabel.backgroundColor = UIColor.clear
        employeeSwitchLabel.textAlignment = NSTextAlignment.left
        return employeeSwitchLabel
    }()
    // Error Label
    public lazy var errorLabel: UILabel = {
        let errorLabel = UILabel(frame: .zero)
        errorLabel.translatesAutoresizingMaskIntoConstraints = false
        errorLabel.text = "Error signing in, check Email and Password and Try Again."
        errorLabel.backgroundColor = UIColor.clear
        errorLabel.numberOfLines = 2
        errorLabel.adjustsFontSizeToFitWidth = true
        errorLabel.textColor = UIColor.red
        errorLabel.font = UIFont.systemFont(ofSize: 13)
        errorLabel.isHidden = true
        errorLabel.textAlignment = NSTextAlignment.center
        return errorLabel
    }()
    // Account Holder Button
    public lazy var accountHolderButton: UIButton = {
        let accountHolderButton = UIButton(frame: .zero)
        accountHolderButton.translatesAutoresizingMaskIntoConstraints = false
        accountHolderButton.setTitle("Already have an account? Sign In", for: .normal)
        accountHolderButton.backgroundColor = UIColor.clear
        accountHolderButton.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        accountHolderButton.setTitleColor(UIColor.red, for: .normal)
        return accountHolderButton
    }()
    // Login Button
    public lazy var registerButton: UIButton = {
        let registerButton = UIButton(frame: .zero)
        registerButton.translatesAutoresizingMaskIntoConstraints = false
        registerButton.setTitleColor(UIColor.white, for: .normal)
        registerButton.setTitle("Register", for: .normal)
        registerButton.layer.cornerRadius = 20
        registerButton.backgroundColor = UIColor(red: 77/255, green: 130/255, blue: 199/255, alpha: 1.0)
        return registerButton
    }()
    // Constraints
    private var customerConstraint: [NSLayoutConstraint]? = nil
    private var employeeConstraint: [NSLayoutConstraint]? = nil
    public var isExpanded: Bool = false {
        didSet {
            isExpanded ? cityField.removeFromSuperview() : expandedConstraints()
            isExpanded ? employeeSkill.removeFromSuperview() : expandedConstraints()
            expandedConstraints()
            if isExpanded {
                NSLayoutConstraint.deactivate(employeeConstraint ?? [NSLayoutConstraint()])
                customerConstraint = [NSLayoutConstraint(item: emptyView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 144)]
                NSLayoutConstraint.activate(customerConstraint ?? [NSLayoutConstraint()])
            } else {
                print("Else, \(isExpanded)")
                NSLayoutConstraint.deactivate(customerConstraint ?? [NSLayoutConstraint()])
                employeeConstraint = [NSLayoutConstraint(item: emptyView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 236)]
                NSLayoutConstraint.activate(employeeConstraint ?? [NSLayoutConstraint()])
            }
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    
    private func setup() {
        // View
        backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)
        // Subviews
        addSubview(emptyView)
        addSubview(nameField)
        addSubview(emailField)
        addSubview(passwordField)
        addSubview(errorLabel)
        addSubview(employeeSwitchLabel)
        addSubview(employeeSwitch)
        addSubview(accountHolderButton)
        addSubview(registerButton)
        // Constraints
        constraints()
    }
    
    
    public func constraints() {
        // Empty View
        emptyView.topAnchor.constraint(equalTo: topAnchor, constant: 150).isActive = true
        emptyView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        emptyView.widthAnchor.constraint(equalTo: widthAnchor, constant: -50).isActive = true
        customerConstraint = [NSLayoutConstraint(item: emptyView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .height, multiplier: 1.0, constant: 144)]
        NSLayoutConstraint.activate(customerConstraint ?? [NSLayoutConstraint()])
        // Name Field
        nameField.topAnchor.constraint(equalTo: emptyView.topAnchor, constant: 6).isActive = true
        nameField.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        nameField.widthAnchor.constraint(equalTo: emptyView.widthAnchor, constant: -20).isActive = true
        nameField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        // Email Field
        emailField.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 6).isActive = true
        emailField.widthAnchor.constraint(equalTo: emptyView.widthAnchor, constant: -20).isActive = true
        emailField.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        emailField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        // Password Field
        passwordField.topAnchor.constraint(equalTo: emailField.bottomAnchor, constant: 6).isActive = true
        passwordField.widthAnchor.constraint(equalTo: emptyView.widthAnchor, constant: -20).isActive = true
        passwordField.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        passwordField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        // Employee Switch Label
        employeeSwitchLabel.topAnchor.constraint(equalTo: emptyView.bottomAnchor, constant: 10).isActive = true
        employeeSwitchLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25).isActive = true
        employeeSwitchLabel.trailingAnchor.constraint(equalTo: employeeSwitch.leadingAnchor).isActive = true
        employeeSwitchLabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        // Employee Switch
        employeeSwitch.topAnchor.constraint(equalTo: emptyView.bottomAnchor, constant: 10).isActive = true
        employeeSwitch.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25).isActive = true
        employeeSwitch.widthAnchor.constraint(equalToConstant: 60).isActive = true
        employeeSwitch.heightAnchor.constraint(equalToConstant: 30).isActive = true
        // Error Label
        errorLabel.bottomAnchor.constraint(equalTo: accountHolderButton.topAnchor, constant: -5).isActive = true
        errorLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: -20).isActive = true
        errorLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        errorLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
        // Account Holder Button
        accountHolderButton.bottomAnchor.constraint(equalTo: registerButton.topAnchor, constant: -10).isActive = true
        accountHolderButton.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        accountHolderButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        accountHolderButton.heightAnchor.constraint(equalToConstant: 35).isActive = true
        // Register Button
        registerButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20).isActive = true
        registerButton.widthAnchor.constraint(equalTo: widthAnchor, constant: -20).isActive = true
        registerButton.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        registerButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    
    private func expandedConstraints() {
        addSubview(cityField)
        addSubview(employeeSkill)
        // City Field
        cityField.topAnchor.constraint(equalTo: emptyView.topAnchor, constant: 144).isActive = true
        cityField.widthAnchor.constraint(equalTo: emptyView.widthAnchor, constant: -20).isActive = true
        cityField.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        cityField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        // Employee Skill
        employeeSkill.topAnchor.constraint(equalTo: cityField.bottomAnchor, constant: 6).isActive = true
        employeeSkill.widthAnchor.constraint(equalTo: emptyView.widthAnchor, constant: -20).isActive = true
        employeeSkill.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        employeeSkill.heightAnchor.constraint(equalToConstant: 40).isActive = true
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
