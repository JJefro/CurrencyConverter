//
//  CurrenciesListViewUITests.swift
//  CurrencyConverterUITests
//
//  Created by Jevgenijs Jefrosinins on 21/01/2022.
//

import XCTest

class CurrenciesListViewUITests: XCTestCase {

    let accessibility = CurrenciesListViewAccessibility()

    var app: XCUIApplication!
    var addCurrencyButton: XCUIElement!

    var navigationBar: XCUIElement!
    var backButton: XCUIElement!

    var searchTextField: XCUIElement!

    var tableView: XCUIElement!

    override func setUpWithError() throws {
        continueAfterFailure = false
        self.app = XCUIApplication()
        self.app.launch()

        addCurrencyButton = app.buttons[accessibility.addCurrencyButton]

        navigationBar = app.navigationBars[accessibility.navigationBar]
        backButton = navigationBar.buttons.element(boundBy: 0)

        searchTextField = navigationBar.searchFields[accessibility.searchTextField]
        tableView = app.tables[accessibility.tableView]
    }

    override func tearDownWithError() throws {
        app = nil

        navigationBar = nil
        backButton = nil

        tableView = nil
        searchTextField = nil
    }

    func test_currenciesListView_presenceOfElements() throws {
        XCTAssertTrue(addCurrencyButton.exists)
        addCurrencyButton.tap()
        XCTAssertTrue(app.isOnCurrenciesListView)
        XCTAssertTrue(navigationBar.exists)
        XCTAssertTrue(backButton.exists)
        XCTAssertTrue(tableView.exists)
        tableView.swipeDown()
        XCTAssertTrue(searchTextField.exists)
    }

    func test_currenciesListView_valuesOfUIElements() throws {
        addCurrencyButton.tap()
        XCTAssertEqual(navigationBar.staticTexts.element.label, "Currencies")
        tableView.swipeDown()
        XCTAssertEqual(searchTextField.placeholderValue, "Search Currency")
        XCTAssertEqual(backButton.label, "Converter")
    }
}
