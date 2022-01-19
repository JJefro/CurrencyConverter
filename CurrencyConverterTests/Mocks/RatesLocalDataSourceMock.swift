//
//  RatesLocalDataSourceMock.swift
//  TextFieldsTests
//
//  Created by Jevgenijs Jefrosinins on 19/01/2022.
//

import Foundation
@testable import CurrencyConverter

class RatesLocalDataSourceMock: RatesLocalDataSourceProtocol {
    @CodableUserDefault(key: "com.jjefro.rates.mock")
    var rates: Timestamped<[CurrencyRate]>?

    @CodableUserDefault(key: "com.jjefro.currencies.mock")
    var trackedCurrencies: [Currency]?
}
