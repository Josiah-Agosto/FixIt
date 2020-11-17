//
//  LocationNameProtocol.swift
//  FixIt
//
//  Created by Josiah Agosto on 11/26/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation

protocol LocationNameProtocol {
    func userEnteredLocation(forString: String)
    var usersLocation: String { get set }
}
