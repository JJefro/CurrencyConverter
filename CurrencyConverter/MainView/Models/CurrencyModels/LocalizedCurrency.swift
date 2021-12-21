//
//  LocalizedCurrency.swift
//  CurrencyConverter
//
//  Created by Jevgenijs Jefrosinins on 11/12/2021.
//

import Foundation

struct LocalizedCurrency {
    let currency: Currency

    var locale: String? {
        let currencyLocale = Locale(identifier: currency.rawValue)
        let currencyName = (currencyLocale as NSLocale).displayName(forKey: NSLocale.Key.currencyCode, value: currency.rawValue)
        guard let name = currencyName else {return nil}
        return name
    }
}
