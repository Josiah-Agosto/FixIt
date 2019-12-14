//
//  ViewController.swift
//  FixIt
//
//  Created by Josiah Agosto on 10/31/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

class Home: UIViewController, HomeTableViewDataProtocol {
    let tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.reloadData()
        return view
    }()
    // For Protocol
    private var homeData = HomeTableViewData()
    // User Variables
    private var userTaskHolder: [UserTaskModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        print("viewDidAppear")
        tableView.reloadData()
    }
    
// MARK: - Setup
    private func setup() {
        view.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)
        self.navigationController?.isNavigationBarHidden = false
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationItem.hidesBackButton = true
        // Table View
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomerCell.self, forCellReuseIdentifier: "cellId")
        // Table View Protocol
        homeData.delegate = self
        // Navigation Bar
        self.title = "Tasks"
        let leftButtonImage = UIImage(systemName: "person.circle")?.withTintColor(UIColor.black, renderingMode: .alwaysOriginal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: leftButtonImage, style: .plain, target: self, action: #selector(displayProfile(sender:)))
        let rightButton = UIImage(systemName: "plus.circle")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: rightButton?.withTintColor(UIColor.black), style: .plain, target: self, action: #selector(addNewFix(sender:)))
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.black
        // Subviews
        self.view.addSubview(tableView)
        // Constraints
        setupConstraints()
    }
    
// MARK: - Actions
    @objc private func displayProfile(sender: UIBarButtonItem) {
        let profileSwiftUIView = UserProfile()
        let hostedView = UIHostingController(rootView: profileSwiftUIView)
        self.navigationController?.present(hostedView, animated: true)
    }
    
    
    @objc private func addNewFix(sender: UIBarButtonItem) {
        let newTaskSwiftUIView = NewTaskView()
        let hostedView = UIHostingController(rootView: newTaskSwiftUIView)
        self.navigationController?.present(hostedView, animated: true)
    }
    
// MARK: - Protocol
    func retrieveUserTasks(userTaskData: [UserTaskModel]) {
        for task in userTaskData {
            userTaskHolder.append(task)
        }
        self.tableView.reloadData()
    }
    
// MARK: - Constraints
    private func setupConstraints() {
        tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        tableView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
    }
} // Class End


// MARK: - TableView Extensions
extension Home: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userTaskHolder.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! CustomerCell
        let modelForIndex = userTaskHolder[indexPath.row] as UserTaskModel
        cell.taskName.text = modelForIndex.userTaskName
        cell.descriptionLabel.text = modelForIndex.taskDescription
        cell.userName.text = modelForIndex.userName
        return cell
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
} // DataSource End



extension Home: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115.0
    }
} // Delegate End

