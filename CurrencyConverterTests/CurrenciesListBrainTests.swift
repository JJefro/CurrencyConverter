//
//  CurrenciesListBrainTests.swift
//  TextFieldsTests
//
//  Created by Jevgenijs Jefrosinins on 19/01/2022.
//

import XCTest
@testable import CurrencyConverter

class CurrenciesListBrainTests: XCTestCase {

    private var model: CurrenciesListBrainProtocol!
    
    private var properties = PropertiesMock()

    override func setUpWithError() throws {
        model = CurrenciesListBrain()
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        model = nil
    }

    func test_model_sortingCurrenciesInSections() throws {
        model.sortCurrenciesInSections(properties.currencyRates.data)

        XCTAssertEqual(model.sections.count, 2)

        XCTAssertEqual(model.sections[0].title, "Popular")
        let euro = properties.currencyRates.data.first(where: { $0.currency == Currency(rawValue: "EUR") })
        XCTAssertEqual(euro, model.sections[0].currencyRates[0])

        let shekel = properties.currencyRates.data.first(where: { $0.currency == Currency(rawValue: "ILS") })
        XCTAssertEqual(shekel, model.sections[0].currencyRates[1])

        let ruble = properties.currencyRates.data.first(where: { $0.currency == Currency(rawValue: "RUB") })
        XCTAssertEqual(ruble, model.sections[0].currencyRates[2])

        let usDollar = properties.currencyRates.data.first(where: { $0.currency == Currency(rawValue: "USD") })
        XCTAssertEqual(usDollar, model.sections[0].currencyRates[3])

        XCTAssertEqual(model.sections[1].title, "A")
        let albanianLek = properties.currencyRates.data.first(where: { $0.currency == Currency(rawValue: "ALL") })
        XCTAssertEqual(albanianLek, model.sections[1].currencyRates[0])

        let australianDollar = properties.currencyRates.data.first(where: { $0.currency == Currency(rawValue: "AUD") })
        XCTAssertEqual(australianDollar, model.sections[1].currencyRates[1])
    }

    func test_model_filterCurrenciesByText() throws {
        let shekel = properties.currencyRates.data.first(where: { $0.currency == Currency(rawValue: "ILS") })

        model.filterCurrencies(properties.currencyRates.data, by: "shekel")
        XCTAssertEqual(model.sections.count, 1)
        XCTAssertEqual(model.sections[0].title, "Popular")
        XCTAssertEqual(model.sections[0].currencyRates[0], shekel)

        let usDollar = properties.currencyRates.data.first(where: { $0.currency == Currency(rawValue: "USD") })
        let australianDollar = properties.currencyRates.data.first(where: { $0.currency == Currency(rawValue: "AUD") })

        model.filterCurrencies(properties.currencyRates.data, by: "Dollar")
        XCTAssertEqual(model.sections.count, 2)

        XCTAssertEqual(model.sections[0].title, "Popular")
        XCTAssertEqual(model.sections[0].currencyRates[0], usDollar)
        XCTAssertEqual(model.sections[0].currencyRates.count, 1)

        XCTAssertEqual(model.sections[1].title, "A")
        XCTAssertEqual(model.sections[1].currencyRates[0], australianDollar)
        XCTAssertEqual(model.sections[1].currencyRates.count, 1)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
