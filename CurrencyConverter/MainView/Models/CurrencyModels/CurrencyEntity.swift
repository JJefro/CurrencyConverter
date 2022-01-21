//
//  CurrencyEntity.swift
//  CurrencyConverter
//
//  Created by Jevgenijs Jefrosinins on 11/12/2021.
//

import Foundation
import UIKit

struct CurrencyEntity {

    static let initialCurrencies: [Currency] = [
        Currency(rawValue: "EUR"),
        Currency(rawValue: "USD")
    ]

    static let popularCurrencies: [Currency] = [
        Currency(rawValue: "USD"),
        Currency(rawValue: "EUR"),
        Currency(rawValue: "RUB"),
        Currency(rawValue: "ILS"),
        Currency(rawValue: "GBP"),
        Currency(rawValue: "JPY"),
        Currency(rawValue: "CNY")
    ]

    var currencyDictionary: [String: Double]
    var baseCurrency: String

    init(_ data: CurrencyData) {
        self.currencyDictionary = data.data
        self.baseCurrency = data.query.baseCurrency
    }

    var data: [CurrencyRate] {
        var data: [CurrencyRate] = []
        let base = Currency.init(rawValue: baseCurrency)
        for item in currencyDictionary {
            let currency = Currency.init(rawValue: item.key)
            if let locale = LocalizedCurrency.init(currency: currency).locale {
                data.append(CurrencyRate(base: base, currency: currency, locale: locale, rate: item.value))
            }
        }
        if !data.contains(where: { $0.currency == Currency.init(rawValue: baseCurrency) }) {
            if let baseLocale = LocalizedCurrency.init(currency: base).locale {
                data.append(CurrencyRate(base: base, currency: base, locale: baseLocale, rate: 1))
            }
        }
        return data.sorted(by: { $0.currency.rawValue < $1.currency.rawValue })
    }
}

#if DEBUG
extension CurrencyEntity {
    static var currencyRatesDataMock: Self {
        .init(CurrencyData(query: CurrencyData.Query(baseCurrency: "EUR"), data: ["ALL": 121.666913, "USD": 1.134919, "AUD": 68.4, "ILS": 3.554, "RUB": 86.536329]))
    }
}
#endif
