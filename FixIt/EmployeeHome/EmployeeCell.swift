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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
    }
    
    
    private func setup() {
        self.contentView.addSubview(taskName)
        self.contentView.addSubview(descriptionLabel)
        self.contentView.addSubview(userName)
    }
}
