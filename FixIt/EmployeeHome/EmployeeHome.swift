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
    private var scrollViewHandler: UIScrollView = {
        let scrollView = UIScrollView(frame: CGRect.zero)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    private var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    // Constants
    lazy var geofenceView = GeofencingMapView()
    private let screenWidth = UIScreen.main.bounds.width
    private let screenHeight = UIScreen.main.bounds.height
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
        scrollViewHandler.delegate = self
        // Navigation Controller
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationItem.hidesBackButton = true
        let leftProfileImage = UIImage(systemName: "person.circle")
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: leftProfileImage, style: .plain, target: self, action: #selector(employeeProfileButtonAction))
        let selectedViewImages = UIImage(systemName: isListDefault ? "map" : "list.bullet")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: selectedViewImages, style: .plain, target: self, action: #selector(listAndMapSwitcherButtonAction))
        self.title = "Issues"
        // Table View
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(EmployeeCell.self, forCellReuseIdentifier: "cellId")
        tableView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        // Scroll View
        scrollViewHandler.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        // Subviews
        view.addSubview(tableView)
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
            add(toViewController: tableView)
            remove(fromViewController: geofenceView)
            print(isListDefault)
            print("List")
        } else {
            add(toViewController: geofenceView)
            remove(fromViewController: tableView)
            print(isListDefault)
            print("Map")
        }
    }
    
    
    private func add(toViewController subView: UIView) {
        view.addSubview(subView)
        subView.frame = view.bounds
    }
    
    
    private func remove(fromViewController subView: UIView) {
        subView.removeFromSuperview()
    }
        
// MARK: Constraints
    private func setupConstraints() {
        // Table View
        tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        tableView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
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



extension EmployeeHome: UIScrollViewDelegate {
    
}
