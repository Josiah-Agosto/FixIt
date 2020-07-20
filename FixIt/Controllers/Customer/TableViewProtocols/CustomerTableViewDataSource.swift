//
//  CustomerTableViewDataSource.swift
//  FixIt
//
//  Created by Josiah Agosto on 5/22/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

class CustomerTableViewDataSource: NSObject, UITableViewDataSource {
    var customerController: CustomerViewController
    
    init(customerController: CustomerViewController) {
        self.customerController = customerController
    }
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Your Issues"
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // customerController.userTaskHolder.count
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch customerController.customerView.hasIssues {
        case true:
            let customerCell = tableView.dequeueReusableCell(withIdentifier: CustomerCell.reuseIdentifier, for: indexPath) as! CustomerCell
            //        let modelForIndex = customerController.userTaskHolder[indexPath.row] as UserTaskModel
            customerCell.taskName.text = "Broken Window Frame"
            //        cell.taskName.text = modelForIndex.userTaskName
            customerCell.descriptionLabel.text = "This is going to be long and it needs to be able to shrink or truncate the words in order for it to keep the same size for the label. I hope this is large enough to not see this."
            //        cell.descriptionLabel.text = modelForIndex.taskDescription
            customerCell.userName.text = "Josiah Agosto"
            //        cell.userName.text = modelForIndex.userName
            customerCell.dateCreatedLabel.text = "September 22, 2000"
            //        cell.dateCreatedLabel.text = modelForIndex.date
            //        Add coordinates for mapView here
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
