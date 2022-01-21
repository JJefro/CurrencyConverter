//
//  MainViewUITests.swift
//  CurrencyConverterUITests
//
//  Created by Jevgenijs Jefrosinins on 21/01/2022.
//

import XCTest

class MainViewUITests: XCTestCase {

    let accessibility = MainViewAccessibility()

    var app: XCUIApplication!

    var navigationBar: XCUIElement!
    var backButton: XCUIElement!

    var converterView: XCUIElement!
    var segmentedControl: XCUIElement!
    var tableView: XCUIElement!

    var shareButton: XCUIElement!
    var addCurrencyButton: XCUIElement!
    var exchangeRateButton: XCUIElement!

    var updateLabel: XCUIElement!
    var dateOfLastUpdateLabel: XCUIElement!

    override func setUpWithError() throws {
        continueAfterFailure = false
        self.app = XCUIApplication()
        self.app.launch()

        navigationBar = app.navigationBars[accessibility.navigationBar]
        backButton = navigationBar.buttons[accessibility.backButton]

        converterView = app.otherElements[accessibility.converterView]
        segmentedControl = converterView.segmentedControls[accessibility.segmentedControl]
        tableView = converterView.tables[accessibility.tableView]

        shareButton = converterView.buttons[accessibility.shareButton]
        addCurrencyButton = converterView.buttons[accessibility.addCurrencyButton]
        exchangeRateButton = app.buttons[accessibility.exchangeRateButton]

        updateLabel = app.staticTexts[accessibility.updateLabel]
        dateOfLastUpdateLabel = app.staticTexts[accessibility.dateOfLastUpdateLabel]
    }

    override func tearDownWithError() throws {
        app = nil

        converterView = nil
        tableView = nil

        shareButton = nil
        addCurrencyButton = nil
        exchangeRateButton = nil

        updateLabel = nil
        dateOfLastUpdateLabel = nil
    }

    func test_mainView_presenceOfElements() throws {
        XCTAssertTrue(app.isOnMainView)
        XCTAssertTrue(navigationBar.exists)
        XCTAssertTrue(converterView.exists)
        XCTAssertTrue(segmentedControl.exists)
        XCTAssertTrue(tableView.exists)

        XCTAssertTrue(shareButton.exists)
        XCTAssertTrue(addCurrencyButton.exists)
        XCTAssertTrue(exchangeRateButton.exists)

        XCTAssertTrue(updateLabel.exists)
        XCTAssertTrue(dateOfLastUpdateLabel.exists)
    }

    func test_mainView_titlesOfUIElements() throws {
        XCTAssertEqual(navigationBar.staticTexts.element.label, "Currency Converter")
        XCTAssertEqual(segmentedControl.buttons.element(boundBy: 0).label, "Sell")
        XCTAssertEqual(segmentedControl.buttons.element(boundBy: 1).label, "Buy")
        XCTAssertEqual(addCurrencyButton.label, "Add Currency")
        XCTAssertEqual(updateLabel.label, "Last Updated")
        XCTAssertEqual(exchangeRateButton.label, "National Bank Exchange Rate")
    }
}
