//
//  CustomerTableViewDataSource.swift
//  FixIt
//
//  Created by Josiah Agosto on 5/22/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

class CustomerTableViewDataSource: NSObject, UITableViewDataSource, HomeTableViewDataProtocol {
    // MARK: - References / Properties
    // Protocol Properties
    var customerIssueTasks: [UserTaskModel] = []
    var hasIssues: Bool = false
    var numberOfIssues: Int = 0
    // MARK: - Methods
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Your Issues"
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfIssues
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch hasIssues {
        case true:
            let customerCell = tableView.dequeueReusableCell(withIdentifier: CustomerCell.reuseIdentifier, for: indexPath) as! CustomerCell
            customerCell.taskName.text = customerIssueTasks[indexPath.row].userTaskName
            customerCell.descriptionLabel.text = customerIssueTasks[indexPath.row].taskDescription
            customerCell.userName.text = customerIssueTasks[indexPath.row].userName
            customerCell.dateCreatedLabel.text = customerIssueTasks[indexPath.row].userDateAdded
            return customerCell
        case false:
            let emptyCell = tableView.dequeueReusableCell(withIdentifier: EmptyIssueCustomerCell.reuseIdentifier, for: indexPath) as! EmptyIssueCustomerCell
            emptyCell.emptyLabel.text = "You currently have no issues."
            return emptyCell
        }
        
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}
