//
//  EmployeeViewController.swift
//  FixIt
//
//  Created by Josiah Agosto on 11/23/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

// TODO: Refactor Geofence View, Add functionality to switch between map and list view, Refactor anything else that needs to be refactored.
class EmployeeViewController: UIViewController {
    // References / Properties
    public lazy var employeeView = EmployeeView()
    lazy var geofenceView = GeofencingMapView()
    private var isListDefault: Bool = true
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        view = employeeView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    // MARK: - Setup
    private func setup() {
        // Navigation Controller
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationItem.hidesBackButton = true
        employeeView.personBarButtonItem = UIBarButtonItem(image: employeeView.personImage, style: .plain, target: self, action: #selector(employeeProfileButtonAction))
        navigationItem.leftBarButtonItem = employeeView.personBarButtonItem
        employeeView.userIssueImage = UIImage(systemName: isListDefault ? "map" : "list.bullet")!
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: employeeView.userIssueImage, style: .plain, target: self, action: #selector(listAndMapSwitcherButtonAction))
        title = "Issues"
    }
    
    // MARK: - Actions
    @objc private func employeeProfileButtonAction(sender: UIBarButtonItem) {
        let profileSwiftUIView = UserProfile()
        let hostedView = UIHostingController(rootView: profileSwiftUIView)
        self.navigationController?.present(hostedView, animated: true)
    }
    
    
    @objc private func listAndMapSwitcherButtonAction(sender: UIBarButtonItem) {
        isListDefault = !isListDefault
        if isListDefault {
            
        } else {
            
        }
    }
} // Class End
