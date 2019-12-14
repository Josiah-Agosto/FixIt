//
//  EmployeeHome.swift
//  FixIt
//
//  Created by Josiah Agosto on 11/23/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

class EmployeeHome: UIViewController {
    private var viewHandler: UIView = {
        let viewHandler = UIView(frame: CGRect.zero)
        viewHandler.translatesAutoresizingMaskIntoConstraints = false
        return viewHandler
    }()
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    // Constants
    private let geofenceView = GeofencingMapView()
    // Variable
    private var isListDefault: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    
    private func setup() {
        view.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)
        // Navigation Controller / Bar
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationItem.hidesBackButton = true
        let leftProfileImage = UIImage(systemName: "person.circle")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: leftProfileImage, style: .plain, target: self, action: #selector(employeeProfileButtonAction))
        let selectedViewImages = UIImage(systemName: isListDefault ? "list.bullet" : "map")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: selectedViewImages, style: .plain, target: self, action: #selector(listAndMapSwitcherButtonAction))
        self.title = "Issues"
        // Table View
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(EmployeeCell.self, forCellReuseIdentifier: "cellId")
        // Subviews
        self.view.addSubview(viewHandler)
        viewHandler.addSubview(tableView)
        viewHandler.addSubview(geofenceView)
        setupConstraints()
    }
    
// MARK: Actions
    @objc private func employeeProfileButtonAction(sender: UIBarButtonItem) {
        let profileSwiftUIView = UserProfile()
        let hostedView = UIHostingController(rootView: profileSwiftUIView)
        self.navigationController?.present(hostedView, animated: true)
    }
    
    
    @objc private func listAndMapSwitcherButtonAction(sender: UIBarButtonItem) {
        isListDefault = !isListDefault
        if isListDefault {
            print("Supposed to be True: \(isListDefault)")
        } else {
            print("Supposed to be False: \(isListDefault)")
        }
    }
        
// MARK: Constraints
    private func setupConstraints() {
        // View Handler
        viewHandler.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        viewHandler.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        viewHandler.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        viewHandler.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        // Table View
        tableView.centerXAnchor.constraint(equalTo: viewHandler.centerXAnchor).isActive = true
        tableView.centerYAnchor.constraint(equalTo: viewHandler.centerYAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: viewHandler.widthAnchor).isActive = true
        tableView.heightAnchor.constraint(equalTo: viewHandler.heightAnchor).isActive = true
        // Map View
        geofenceView.centerXAnchor.constraint(equalTo: viewHandler.centerXAnchor).isActive = true
        geofenceView.centerYAnchor.constraint(equalTo: viewHandler.centerYAnchor).isActive = true
        geofenceView.widthAnchor.constraint(equalTo: viewHandler.widthAnchor).isActive = true
        geofenceView.heightAnchor.constraint(equalTo: viewHandler.heightAnchor).isActive = true
    }
} // Class End


// MARK: Table View Extension
extension EmployeeHome: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}



extension EmployeeHome: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115.0
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Accepted Issues"
        }
        return ""
    }
}
