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
        if let value = exchangeValue {
            return String(format: "%.2f", value)
        }
        return nil
    }
}
