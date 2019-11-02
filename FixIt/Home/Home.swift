//
//  ViewController.swift
//  FixIt
//
//  Created by Josiah Agosto on 10/31/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

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
    
    
    private func setup() {
        view.backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.barTintColor = view.backgroundColor
        self.navigationItem.setHidesBackButton(true, animated: true)
        // Table View
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CustomerCell.self, forCellReuseIdentifier: "cellId")
        // Navigation Bar
        self.title = "Tasks"
        let leftButton = UIImage(systemName: "person.crop.square")
        leftButton?.withTintColor(UIColor.red)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: leftButton, style: .plain, target: self, action: #selector(displayProfile(sender:)))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(addNewFix(sender:)))
        // Subviews
        self.view.addSubview(tableView)
        // Constraints
        setupConstraints()
    }
    
    
    @objc private func displayProfile(sender: UIBarButtonItem) {
        print("Profile")
    }
    
    
    @objc private func addNewFix(sender: UIBarButtonItem) {
        print("New Fix")
    }
    
    
    private func setupConstraints() {
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    
} // Class End



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
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
}



extension Home: UITableViewDelegate {
    
}

