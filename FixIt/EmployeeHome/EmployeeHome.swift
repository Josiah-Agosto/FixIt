//
//  EmployeeHome.swift
//  FixIt
//
//  Created by Josiah Agosto on 11/23/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

class EmployeeHome: UIViewController {
    private var tableView: UITableView = {
        let tableView = UITableView()
        
        return tableView
    }()
    // Variable
    private var isListDefault: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupConstraints()
    }
    
    
    private func setup() {
        view.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)
        // Navigation Controller / Bar
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationItem.hidesBackButton = true
        // TODO: Add Table View and Maps view button
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
        view.addSubview(tableView)
    }
    
// MARK: Actions
    @objc private func employeeProfileButtonAction(sender: UIBarButtonItem) {
        print("Profile")
    }
    
    
    @objc private func listAndMapSwitcherButtonAction(sender: UIBarButtonItem) {
        isListDefault = !isListDefault
        if !isListDefault {
            print("Supposed to be True \(isListDefault)")
        } else {
            print("Supposed to be False \(isListDefault)")
        }
        print("List")
    }
        
// MARK: Constraints
    private func setupConstraints() {
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
} // Class End



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
