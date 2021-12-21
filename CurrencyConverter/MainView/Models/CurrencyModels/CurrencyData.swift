//
//  CurrencyData.swift
//  CurrencyConverter
//
//  Created by Jevgenijs Jefrosinins on 13/12/2021.
//

import Foundation

struct CurrencyData: Codable {
    let query: Query
    let data: [String: Double]

    struct Query: Codable {
        let baseCurrency: String

        private enum CodingKeys: String, CodingKey {
            case baseCurrency = "base_currency"
        }
    }
}
