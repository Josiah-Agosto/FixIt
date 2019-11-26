//
//  MapTableViewCell.swift
//  FixIt
//
//  Created by Josiah Agosto on 11/25/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

class MapTableViewCell: UITableViewCell {
    var locationText: UILabel = {
        let label = UILabel()
        label.frame = CGRect.zero
        label.textAlignment = NSTextAlignment.left
        label.font = UIFont(name: "AvenirNext", size: 25)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setup()
        constraintSetup()
    }
    
    
    private func setup() {
        self.addSubview(locationText)
    }
    
    
    private func constraintSetup() {
        locationText.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        locationText.heightAnchor.constraint(equalTo: self.heightAnchor).isActive = true
        locationText.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        locationText.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}
