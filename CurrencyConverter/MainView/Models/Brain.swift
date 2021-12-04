//
//  Brain.swift
//  CurrencyConverter
//
//  Created by Jevgenijs Jefrosinins on 04/12/2021.
//

import Foundation

class Brain {

    func getCurrentDataString() -> String {
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .medium
        return formatter.string(from: currentDate)
    }
}
