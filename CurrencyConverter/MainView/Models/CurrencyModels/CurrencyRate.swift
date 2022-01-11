//
//  CurrencyData.swift
//  CurrencyConverter
//
//  Created by Jevgenijs Jefrosinins on 07/12/2021.
//

import Foundation

struct CurrencyRate: Codable, Equatable {
    var base: Currency
    var currency: Currency
    var locale: String
    var rate: Double
}
