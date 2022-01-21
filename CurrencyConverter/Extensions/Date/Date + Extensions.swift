//
//  Date+Comparison.swift
//  CurrencyConverter
//
//  Created by Jevgenijs Jefrosinins on 18/12/2021.
//

import Foundation

extension Date {
    var isInHourIntervalWithCurrentTime: Bool {
        let currentDateRoundedToHour = Calendar.current.dateComponents([.hour, .day, .month, .year], from: Date())
        let hourOfTheLastUpdate = Calendar.current.dateComponents([.hour, .day, .month, .year], from: self)
        return currentDateRoundedToHour == hourOfTheLastUpdate
    }
}
