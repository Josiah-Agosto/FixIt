//
//  ErrorControllerProtocol.swift
//  FixIt
//
//  Created by Josiah Agosto on 6/10/20.
//  Copyright © 2020 Josiah Agosto. All rights reserved.
//

import Foundation
import UIKit

protocol ErrorControllerProtocol: class {
    func locationErrorController(with title: String, and description: String)
}
