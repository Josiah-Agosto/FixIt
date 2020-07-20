//
//  EmployeeView.swift
//  FixIt
//
//  Created by Josiah Agosto on 5/20/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import UIKit

class EmployeeView: UIView {
    // Properties / References
    // Table View
    public lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    // Person Image
    public lazy var personImage: UIImage = {
        let image = UIImage(systemName: "person.circle")!
        return image
    }()
    // Person Bar Item
    public lazy var personBarButtonItem: UIBarButtonItem = {
        let barItem = UIBarButtonItem()
        return barItem
    }()
    // User Issue Toggle
    public lazy var userIssueImage: UIImage = {
        let image = UIImage()
        return image
    }()
    private lazy var employeeController = EmployeeViewController()
    // Table View Delegates
    public var employeeIssueTableViewDelegate: EmployeeIssueTableViewDelegate?
    public var employeeIssueTableViewDataSource: EmployeeIssueTableViewDataSource?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    
    private func setup() {
        // View
        backgroundColor = UIColor(red: 220/255, green: 220/255, blue: 220/255, alpha: 1.0)
        // Delegates
        employeeIssueTableViewDelegate = EmployeeIssueTableViewDelegate(employeeController: employeeController)
        employeeIssueTableViewDataSource = EmployeeIssueTableViewDataSource(employeeController: employeeController)
        tableView.delegate = employeeIssueTableViewDelegate
        tableView.dataSource = employeeIssueTableViewDataSource
        tableView.register(EmployeeCell.self, forCellReuseIdentifier: EmployeeCell.reuseIdentifier)
        // Subviews
        addSubview(tableView)
        // Constraints
        constraints()
    }
    
    
    private func constraints() {
        // Table View
        tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
