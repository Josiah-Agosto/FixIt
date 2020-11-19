//
//  LocationManagerProtocol.swift
//  FixIt
//
//  Created by Josiah Agosto on 11/17/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation

protocol LocationManagerProtocol: class {
    func userEnteredLocation(forString: String)
    var usersLocation: String { get set }
}
