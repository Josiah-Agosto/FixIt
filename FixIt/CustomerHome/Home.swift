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

class Home: UIViewController {
    let tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.allowsSelection = true
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
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
    
// MARK: - Constraints
    private func setupConstraints() {
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
} // Class End


// MARK: - TableView Extensions
extension Home: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! CustomerCell
        cell.taskName.text = "Put up a Ceiling Fan"
        cell.descriptionLabel.text = "Some stuff here just for now to see how it looks. Some stuff here just for now to see how it looks. Some stuff here just for now to see how it looks. Some stuff here just for now to see how it looks. Some stuff here just for now to see how it looks."
        cell.userName.text = "Josiah Agosto"
        return cell
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}



extension Home: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115.0
    }
}

