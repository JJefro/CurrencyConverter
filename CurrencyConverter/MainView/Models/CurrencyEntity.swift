//
//  CurrencyEntity.swift
//  CurrencyConverter
//
//  Created by Jevgenijs Jefrosinins on 11/12/2021.
//

import Foundation
import UIKit

struct CurrencyEntity {

    var currencyDictionary: [String: Double]
    var baseCurrency: Currency

    init(_ data: CurrencyData, baseCurrency: Currency) {
        self.currencyDictionary = data.data
        self.baseCurrency = baseCurrency
    }

    var data: [CurrencyRate] {
        var data: [CurrencyRate] = []
        for item in currencyDictionary {
            let currency = Currency.init(rawValue: item.key)
            if let locale = LocalizedCurrency.init(currency: currency).locale {
                data.append(CurrencyRate(base: baseCurrency, currency: currency, locale: locale, rate: item.value))
            }
        }
        return data.sorted(by: { $0.currency.rawValue < $1.currency.rawValue })
    }
}
