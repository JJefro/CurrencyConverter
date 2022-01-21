//
//  CurrencyConverterUITests + Extensions.swift
//  CurrencyConverterUITests
//
//  Created by Jevgenijs Jefrosinins on 21/01/2022.
//

import XCTest

extension XCUIApplication {

    var isOnMainView: Bool {
        return otherElements["mainView"].exists
    }

    var isOnCurrenciesListView: Bool {
        return otherElements["currenciesListView"].exists
    }
}
