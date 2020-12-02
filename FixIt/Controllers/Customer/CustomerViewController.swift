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
    private let firebaseHelper = FirebaseHelperClass()
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
        checkingIfUserHasIssues()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        customerMonitor.fetchUpdates()
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
        NotificationCenter.default.addObserver(self, selector: #selector(issuesAdded(_:)), name: .issuesAdded, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(issuesChanged(_:)), name: .issuesChanged, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(issuesRemoved(_:)), name: .issuesRemoved, object: nil)
    }
    
    
    deinit {
        resetCustomerData()
    }
    
    /// Checks to see whether the table view needs to update to show issues.
    public func checkingIfUserHasIssues() {
        getUserIssues()
        firebaseHelper.numberOfUserIssues { (issues) in
            switch issues {
                case 0:
                    self.locationManager = nil
                    return
                default:
                    DispatchQueue.main.async {
                        self.locationManager = LocationManager.shared
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
    
    // MARK: - Observers
    // Issue was added.
    @objc private func issuesAdded(_ notification: Notification) {
        print("Added")
        checkingIfUserHasIssues()
    }
    
    // Issue was changed.
    @objc private func issuesChanged(_ notification: Notification) {
        print("Changed")
        checkingIfUserHasIssues()
    }
    
    // issue was removed.
    @objc private func issuesRemoved(_ notification: Notification) {
        print("Removed")
        checkingIfUserHasIssues()
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
    
    
    private func resetCustomerData() {
        customerDataSource.customerIssueTasks = []
        customerDataSource.hasIssues = false
        customerDataSource.numberOfIssues = 0
    }
} // Class End
