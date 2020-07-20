//
//  LaunchScreenController.swift
//  FixIt
//
//  Created by Josiah Agosto on 5/26/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import UIKit

class LaunchScreenController: UIViewController {
    // References / Properties
    public lazy var launchScreenView = LaunchScreenView()

    override func loadView() {
        super.loadView()
        view = launchScreenView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    
    private func setup() {
        
    }

}
