//
//  CurrencyExchangeData.swift
//  CurrencyConverter
//
//  Created by Jevgenijs Jefrosinins on 11/01/2022.
//

import Foundation

struct CurrencyExchangeData {
    let currency: Currency
    let rate: Double
    var exchangeValue: Double?

    var exchangeValueString: String? {
        return exchangeValue.map { String(format: "%.2f", $0) }
    }
}
