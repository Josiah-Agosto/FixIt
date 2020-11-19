//
//  HomeTableViewDataProtocol.swift
//  FixIt
//
//  Created by Josiah Agosto on 11/19/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import Foundation

protocol HomeTableViewDataProtocol: class {
    var customerIssueTasks: [UserTaskModel] { get set }
    var hasIssues: Bool { get set }
    var numberOfIssues: Int { get set }
}
