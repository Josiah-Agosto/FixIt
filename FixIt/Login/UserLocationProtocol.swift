//
//  UserLocationDelegate.swift
//  FixIt
//
//  Created by Josiah Agosto on 11/6/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation

protocol UserLocationProtocol {
    func getLocationName(location: String)
    func getUserState(location: String)
}
