//
//  EmployeeIssueTableViewDelegate.swift
//  FixIt
//
//  Created by Josiah Agosto on 5/25/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

class EmployeeIssueTableViewDelegate: NSObject, UITableViewDelegate {
    private var employeeController: EmployeeViewController
    
    init(employeeController: EmployeeViewController) {
        self.employeeController = employeeController
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 115.0
    }
}
