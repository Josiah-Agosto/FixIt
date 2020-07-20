//
//  HomeTableViewCell.swift
//  FixIt
//
//  Created by Josiah Agosto on 11/1/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import UIKit
import MapKit

class CustomerCell: UITableViewCell {
    // Properties / References
    static let reuseIdentifier = "CustomerCell"
    // User id
    public var userId: String = ""
    // Map
    public lazy var mapView: MKMapView = {
        let view = MKMapView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 40
        view.isUserInteractionEnabled = false
        view.showsBuildings = false
        view.showsTraffic = false
        return view
    }()
    // Task Name
    public lazy var taskName: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Stuff Here to show a Task"
        label.font = UIFont(name: "AvenirNext-Medium", size: 20)
        label.backgroundColor = UIColor.clear
        label.textAlignment = NSTextAlignment.left
        return label
    }()
    public lazy var descriptionLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "This is going to be rather large so let me make this pretty long to see if it will fit inside the text stuff. Possibly this will be a scrollable text view. Or not."
        label.numberOfLines = 0
        label.font = UIFont(name: "AvenirNext", size: 18)
        label.backgroundColor = UIColor.clear
        label.textAlignment = NSTextAlignment.left
        return label
    }()
    public lazy var userName: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Somelong Namehere"
        label.font = UIFont(name: "Avenir-Light", size: 12)
        label.backgroundColor = UIColor.clear
        label.textAlignment = NSTextAlignment.left
        return label
    }()
    public lazy var dateCreatedLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "Avenir-Light", size: 12)
        label.backgroundColor = UIColor.clear
        label.textAlignment = NSTextAlignment.left
        return label
    }()
    public lazy var detailView: UIView  = {
        let detailView = UIView(frame: .zero)
        detailView.translatesAutoresizingMaskIntoConstraints = false
        detailView.backgroundColor = .clear
        return detailView
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    
    private func setup() {
        // View
        // Subviews
        addSubview(mapView)
        addSubview(detailView)
        detailView.addSubview(taskName)
        detailView.addSubview(descriptionLabel)
        detailView.addSubview(userName)
        detailView.addSubview(dateCreatedLabel)
        // Constraints
        constraints()
    }
    
    
    private func constraints() {
        // Map View
        mapView.widthAnchor.constraint(equalToConstant: 85).isActive = true
        mapView.heightAnchor.constraint(equalToConstant: 85).isActive = true
        mapView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        mapView.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        // Detail View
        detailView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 100).isActive = true
        detailView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        detailView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        detailView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        // Task Name
        taskName.leadingAnchor.constraint(equalTo: detailView.leadingAnchor).isActive = true
        taskName.topAnchor.constraint(equalTo: detailView.topAnchor, constant: 1).isActive = true
        taskName.heightAnchor.constraint(equalToConstant: 20).isActive = true
        taskName.trailingAnchor.constraint(equalTo: detailView.trailingAnchor).isActive = true
        // Description
        descriptionLabel.topAnchor.constraint(equalTo: taskName.bottomAnchor).isActive = true
        descriptionLabel.leadingAnchor.constraint(equalTo: detailView.leadingAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: detailView.trailingAnchor).isActive = true
        descriptionLabel.heightAnchor.constraint(equalToConstant: 65).isActive = true
        // User name
        userName.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor).isActive = true
        userName.leadingAnchor.constraint(equalTo: detailView.leadingAnchor).isActive = true
        userName.heightAnchor.constraint(equalToConstant: 14).isActive = true
        userName.trailingAnchor.constraint(equalTo: detailView.trailingAnchor).isActive = true
        // Date
        dateCreatedLabel.topAnchor.constraint(equalTo: userName.bottomAnchor, constant: 2).isActive = true
        dateCreatedLabel.leadingAnchor.constraint(equalTo: detailView.leadingAnchor).isActive = true
        dateCreatedLabel.heightAnchor.constraint(equalToConstant: 10).isActive = true
        dateCreatedLabel.trailingAnchor.constraint(equalTo: detailView.trailingAnchor).isActive = true
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
