//
//  EmployeeCell.swift
//  FixIt
//
//  Created by Josiah Agosto on 11/23/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

class EmployeeCell: UITableViewCell {
    static let reuseIdentifier = "EmployeeCell"
    // Task Name
    let taskName: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 8, y: 0, width: UIScreen.main.bounds.width - 16, height: 30)
        label.text = "Stuff Here to show a Task"
        label.font = UIFont(name: "AvenirNext-Medium", size: 25)
        label.backgroundColor = UIColor.clear
        label.textAlignment = NSTextAlignment.left
        return label
    }()
    // Description Label
    let descriptionLabel: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 8, y: 30, width: UIScreen.main.bounds.width - 16, height: 60)
        label.text = "This is going to be rather large so let me make this pretty long to see if it will fit inside the text stuff. Possibly this will be a scrollable text view. This is going to be rather large so let me make this pretty long to see if it will fit inside the text stuff. Possibly this will be a scrollable text view. This is going to be rather large so let me make this pretty long to see if it will fit inside the text stuff. Possibly this will be a scrollable text view."
        label.numberOfLines = 0
        label.font = UIFont(name: "AvenirNext-Light", size: 16)
        label.adjustsFontSizeToFitWidth = true
        label.backgroundColor = UIColor.clear
        label.textAlignment = NSTextAlignment.left
        return label
    }()
    let userName: UILabel = {
        let label = UILabel()
        label.frame = CGRect(x: 8, y: 95, width: UIScreen.main.bounds.width - 16, height: 15)
        label.text = "Somelong Namehere"
        label.font = UIFont(name: "AvenirNext-Medium", size: 13)
        label.backgroundColor = UIColor.clear
        label.textAlignment = NSTextAlignment.left
        return label
    }()
    // Optional Image
    let issueImage: UIImageView = {
        let view = UIImageView(frame: CGRect(x: UIScreen.main.bounds.width / 3, y: 0, width: 115, height: 115))
        view.contentMode = .scaleAspectFit
        view.backgroundColor = UIColor.green
        return view
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    
    private func setup() {
        // View
        // Subviews
        addSubview(taskName)
        addSubview(descriptionLabel)
        addSubview(userName)
        // Constraints
    }
    
    
    private func constraints() {
        // TODO: Add Constraints Here
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
