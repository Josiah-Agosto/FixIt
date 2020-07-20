//
//  CustomerTableViewDelegate.swift
//  FixIt
//
//  Created by Josiah Agosto on 5/22/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

class CustomerTableViewDelegate: NSObject, UITableViewDelegate {
    var customerController: CustomerViewController
    
    init(customerController: CustomerViewController) {
        self.customerController = customerController
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return customerController.customerView.hasIssues ? 115.0 : 50.0
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: Add stuff here
    }
}
