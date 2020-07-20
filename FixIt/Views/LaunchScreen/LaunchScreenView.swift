//
//  LaunchScreenView.swift
//  FixIt
//
//  Created by Josiah Agosto on 5/26/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

class LaunchScreenView: UIView {
    // Properties / References
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    
    private func setup() {
        // View
        backgroundColor = UIColor.lightGray
        // Subviews
        // Constraints
        constraints()
    }
    
    
    private func constraints() {
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
