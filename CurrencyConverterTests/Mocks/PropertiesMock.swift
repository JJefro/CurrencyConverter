//
//  PropertiesMock.swift
//  CurrencyConverter
//
//  Created by Jevgenijs Jefrosinins on 19/01/2022.
//

import Foundation
@testable import CurrencyConverter

struct PropertiesMock {

    let url = URL(string: "www.example.com")
    let baseCurrency: Currency = .init(rawValue: "EUR")
    let currencyRates = CurrencyEntity.currencyRatesMock
    let trackedCurrencies = [Currency(rawValue: "EUR"), Currency(rawValue: "USD"), Currency(rawValue: "RUB")]
}
