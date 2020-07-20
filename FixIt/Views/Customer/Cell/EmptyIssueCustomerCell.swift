//
//  EmptyIssueCustomerCell.swift
//  FixIt
//
//  Created by Josiah Agosto on 7/13/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import UIKit

class EmptyIssueCustomerCell: UITableViewCell {
    // Properties / References
    static let reuseIdentifier = "NoIssueCell"
    // Label
    public lazy var emptyLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .clear
        label.textAlignment = .center
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    
    private func setup() {
        // View
        addSubview(emptyLabel)
        // Constraints
        constraints()
    }

    
    private func constraints() {
        // Label
        emptyLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        emptyLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        emptyLabel.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        emptyLabel.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
