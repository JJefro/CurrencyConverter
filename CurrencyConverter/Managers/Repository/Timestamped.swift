//
//  Timestamped.swift
//  CurrencyConverter
//
//  Created by Jevgenijs Jefrosinins on 18/12/2021.
//

import Foundation

struct Timestamped<T: Codable>: Codable {
    var createdAt = Date()
    let wrappedValue: T
}
