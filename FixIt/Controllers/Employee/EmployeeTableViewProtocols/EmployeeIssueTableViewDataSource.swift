//
//  EmployeeIssueTableViewDataSource.swift
//  FixIt
//
//  Created by Josiah Agosto on 5/24/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

class EmployeeIssueTableViewDataSource: NSObject, UITableViewDataSource {
    private var employeeController: EmployeeViewController
    
    init(employeeController: EmployeeViewController) {
        self.employeeController = employeeController
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Issues Near Me"
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // TODO: Add cell stuff to show when there has been issues made
        return UITableViewCell()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
