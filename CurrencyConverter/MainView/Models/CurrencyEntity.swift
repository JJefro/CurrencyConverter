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

    init(_ data: CurrencyData) {
        self.currencyDictionary = data.data
    }

    var data: [CurrencyRate] {
        var data: [CurrencyRate] = []
        for item in currencyDictionary {
            if let currency = Currency.allCases.first(where: { String(describing: $0) == item.key }) {
                data.append(CurrencyRate(currency: currency, rate: item.value))
            }
        }
        return data.sorted(by: {
            String(describing: $0.currency) < String(describing: $1.currency)
        })
    }
}
