//
//  TopAlbumsUITests.swift
//  TopAlbumsUITests
//
//  Created by Jonny Klemmer on 12/31/18.
//  Copyright © 2018 Jonny Klemmer. All rights reserved.
//

import XCTest

class TopAlbumsUITests: XCTestCase {

    override func setUp() {
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()
    }

    func testLoadingAlbumListAndDetails() {
        let app = XCUIApplication()
        let tableQuery = app.tables
        let cellsQuery = tableQuery.cells
        
        let count = NSPredicate(format: "count == 100")
        expectation(for: count, evaluatedWith: cellsQuery, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        
        let cellElements = cellsQuery.allElementsBoundByIndex
        cellElements[0].tap()
        
        let backButton = app.navigationBars["Details"].buttons["iTunes Top 100"]
        backButton.tap()
        
        cellElements[99].tap()
        
        backButton.tap()
    }

}
