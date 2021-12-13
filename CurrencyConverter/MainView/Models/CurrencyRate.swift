//
//  CurrencyData.swift
//  CurrencyConverter
//
//  Created by Jevgenijs Jefrosinins on 07/12/2021.
//

import Foundation

struct CurrencyRate {
    var currency: Currency
    var rate: Double

    var rateString: String {
        return String(format: "%.2f", rate)
    }
}
