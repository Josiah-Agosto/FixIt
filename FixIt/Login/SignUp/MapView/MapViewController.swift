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
        return tableView
    }()
    // Variables
    private var showingTableView: Bool = false
// MARK: - View Did Load
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupConstraints()
    }
    
// MARK: - Setups
    private func setup() {
        self.navigationController?.isNavigationBarHidden = false
        searchControllerTableView.delegate = self
        searchControllerTableView.dataSource = self
        setupSearchController()
        setupSearchBar()
        setupTableView()
        self.view.addSubview(mapView)
        self.view.addSubview(searchBarContainer)
        self.view.addSubview(searchControllerTableView)
    }
    

    private func setupSearchBar() {
        let searchBar = resultSearchController!.searchBar
        searchBar.sizeToFit()
        searchBar.placeholder = "Ex: City, State"
        searchBarContainer.addSubview(searchBar)
    }
    
    
    private func setupSearchController() {
        resultSearchController = UISearchController(searchResultsController: nil)
        resultSearchController?.searchResultsUpdater = self
        resultSearchController?.obscuresBackgroundDuringPresentation = true
        resultSearchController?.searchBar.delegate = self
        resultSearchController?.hidesNavigationBarDuringPresentation = false
        definesPresentationContext = true
    }
    
    
    private func setupTableView() {
        searchControllerTableView.register(MapTableViewCell.self, forCellReuseIdentifier: "cell")
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
        print("Searched")
        showingTableView = false
    }
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        print("Cancelled")
        showingTableView = false
    }
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        showingTableView = true
    }
}


// MARK: - Search Table View Extensions
extension MapViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
}



extension MapViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MapTableViewCell
        cell.locationText.text = "Stuff"
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40.0
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if showingTableView == false {
            self.searchControllerTableView.isHidden = true
        } else {
            self.searchControllerTableView.isHidden = false
        }
    }
}

