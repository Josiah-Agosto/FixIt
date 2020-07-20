//
//  FixItTests.swift
//  FixItTests
//
//  Created by Josiah Agosto on 12/25/19.
//  Copyright © 2019 Josiah Agosto. All rights reserved.
//

import XCTest
@testable import FixIt

class FixItTests: XCTestCase {
    private var mockUserDefault: UserDefaults!

    override func setUp() {
        testLoggedInFunctions()
    }

    override func tearDown() {
        mockUserDefault = nil
    }

    func testLoggedInFunctions() {
        mockUserDefault = UserDefaults.standard
        var mockedLogIn: Bool = false
        mockUserDefault.set(mockedLogIn, forKey: "mockUserDefault")
        DataRetriever().saveSetting(for: mockedLogIn, forKey: "mockUserDefault")
        
        mockedLogIn = true
        DataRetriever().saveSetting(for: mockedLogIn, forKey: "mockUserDefault")
        
        XCTAssertEqual(true, mockedLogIn)
    }

}
