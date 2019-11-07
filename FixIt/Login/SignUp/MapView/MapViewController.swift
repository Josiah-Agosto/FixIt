//
//  ViewController.swift
//  MapKitPlayground
//
//  Created by Josiah Agosto on 6/9/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {
    var resultSearchController: UISearchController? = nil
    let mapView: MKMapView = {
        let mapView = MKMapView(frame: CGRect.zero)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        return mapView
    }()
    let searchBarContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let searchControllerTableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.isHidden = true
        return tableView
    }()
// MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupConstraints()
    }
    
// MARK: - Setup
    private func setup() {
        searchControllerTableView.delegate = self
        searchControllerTableView.dataSource = self
        setupSearchController()
        setupSearchBar()
        self.view.addSubview(mapView)
        self.view.addSubview(searchBarContainer)
        self.view.addSubview(searchControllerTableView)
        self.navigationController?.isNavigationBarHidden = false
    }
    
// MARK: - Search Controller Setup
    private func setupSearchBar() {
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Search your town"
        searchBarContainer.addSubview(searchBar)
        if searchBar.isUserInteractionEnabled == true {
            searchControllerTableView.isHidden = false
        } else {
            searchControllerTableView.isHidden = true
        }
    }
    
    
    private func setupSearchController() {
        resultSearchController = UISearchController(searchResultsController: nil)
        resultSearchController?.searchResultsUpdater = self
        resultSearchController?.obscuresBackgroundDuringPresentation = true
        resultSearchController?.searchBar.delegate = self
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true
    }
    
// MARK: - Constraints
    private func setupConstraints() {
        // Map View
        mapView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        mapView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        mapView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        mapView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        // Search Container
        searchBarContainer.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        searchBarContainer.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        searchBarContainer.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        searchBarContainer.heightAnchor.constraint(equalToConstant: 50).isActive = true
        // Table View
        searchControllerTableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        searchControllerTableView.topAnchor.constraint(equalTo: searchBarContainer.bottomAnchor).isActive = true
        searchControllerTableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        searchControllerTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
} // Class End


// MARK: - Search Controller Updater Protocol
extension MapViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}


// MARK: - Search Bar Delegate
extension MapViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
    }
}


// MARK: - Search Table View Extensions
extension MapViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
}



extension MapViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

