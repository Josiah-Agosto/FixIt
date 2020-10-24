//
//  CustomerViewController.swift
//  FixIt
//
//  Created by Josiah Agosto on 10/31/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

class CustomerViewController: UIViewController {
    // References / Properties
    private lazy var globalHelper = GlobalHelper.shared
    public lazy var customerView = CustomerView()
    private var homeData: HomeTableViewData?
    private var locationManager: LocationManager?
    @State private var isPresented: Bool = false
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        view = customerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkingIfUserHasIssues()
    }
    
    // MARK: - Setup Functions
    private func setup() {
        navigationController?.isNavigationBarHidden = false
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationController?.navigationBar.barTintColor = UIColor.white
        navigationItem.hidesBackButton = true
        // Navigation Bar
        title = "Tasks"
        customerView.profileBarButtonItem = UIBarButtonItem(image: customerView.customerProfileImage, style: .plain, target: self, action: #selector(displayProfile(sender:)))
        navigationItem.leftBarButtonItem = customerView.profileBarButtonItem
        customerView.addBarButtonItem = UIBarButtonItem(image: customerView.addImage, style: .plain, target: self, action: #selector(addNewFix(sender:)))
        navigationItem.rightBarButtonItem = customerView.addBarButtonItem
        // Delegate
        homeData?.delegate = self
    }
    
    // Checks to see whether the table view needs to update to show issues.
    public func checkingIfUserHasIssues() {
        globalHelper.retrieveNumberOfIssues { (issues) in
            switch issues {
                case 0:
                    self.customerView.hasIssues = false
                    self.locationManager = nil
                    return
                default:
                    self.customerView.hasIssues = true
                    self.locationManager = LocationManager()
                    self.refreshToGetIssues()
                    self.retrieveUserData()
                    return
            }
        }
    }
    
    // MARK: Private Functions
    private func refreshToGetIssues() {
        homeData = HomeTableViewData()
    }
    
    private func retrieveUserData() {
        globalHelper.retrieveUserTasks()
    }
    
    // MARK: - Actions
    @objc private func displayProfile(sender: UIBarButtonItem) {
        let profileSwiftUIView = UserProfile()
        let hostedView = UIHostingController(rootView: profileSwiftUIView)
        navigationController?.present(hostedView, animated: true)
    }
    
    
    @objc private func addNewFix(sender: UIBarButtonItem) {
        // Initialized Observed Object
        let presentedObjectDelegate = PresentedObject()
        // Assign Object Property
        presentedObjectDelegate.navigationController = navigationController
        // Assign Object to New SwiftUI View
        let newTaskSwiftUIView = NewTaskView().environmentObject(presentedObjectDelegate)
        let hostedView = UIHostingController(rootView: newTaskSwiftUIView)
        navigationController?.present(hostedView, animated: true)
    }
} // Class End



// MARK: User Task Extension
extension CustomerViewController: HomeTableViewDataProtocol {
    func retrieveUserTasks(userTaskData: [UserTaskModel]) {
        for task in userTaskData {
            Constants.userTaskHolder.append(task)
        }
        customerView.tableView.reloadData()
    }
}
