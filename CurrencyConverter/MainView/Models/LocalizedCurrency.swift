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
        let currencyLocale = Locale(identifier: String(describing: currency))
        let currencyName = (currencyLocale as NSLocale).displayName(forKey: NSLocale.Key.currencyCode, value: String(describing: currency))
        guard let name = currencyName else {return nil}
        return name
    }
}
