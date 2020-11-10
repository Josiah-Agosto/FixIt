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
    public lazy var customerMonitor = CustomerIssueMonitor.shared
    public lazy var customerView = CustomerView()
    public var homeData: CustomerTableViewData?
    private var locationManager: LocationManager?
    // Table View Protocols
    private var customerDelegate: CustomerTableViewDelegate?
    public let customerDataSource = CustomerTableViewDataSource()
    // New Issue Bool
    @State private var isPresented: Bool = false
    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()
        view = customerView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        customerMonitor.fetchUpdates()
        checkingIfUserHasIssues()
    }
    
    // MARK: - Setup Functions
    private func setup() {
        // Table View
        customerDelegate = CustomerTableViewDelegate(customerController: self)
        customerView.tableView.delegate = customerDelegate
        customerView.tableView.dataSource = customerDataSource
        // Delegate
        homeData = CustomerTableViewData()
        homeData?.delegate = customerDataSource
        // Navigation Controller
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
        // Notifications
        NotificationCenter.default.addObserver(self, selector: #selector(customerIssuesChanged(_:)), name: .customerIssues, object: nil)
        
    }
    
    // Checks to see whether the table view needs to update to show issues.
    public func checkingIfUserHasIssues() {
        getUserIssues()
        homeData?.retrieveNumberOfIssues { (issues) in
            switch issues {
                case 0:
                    self.locationManager = nil
                    return
                default:
                    DispatchQueue.main.async {
                        self.locationManager = LocationManager()
                    }
                    self.setupReloadTableView()
                    return
            }
        }
    }
    
    // MARK: - Private Functions
    private func getUserIssues() {
        homeData?.getUserTasks()
    }
    
    /// Called only after view did load.
    private func setupReloadTableView() {
        DispatchQueue.main.async {
            self.customerView.tableView.reloadData()
        }
    }
    
    // MARK: - Actions
    @objc private func customerIssuesChanged(_ notification: Notification) {
        print("Changed!!!")
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
