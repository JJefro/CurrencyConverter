//
//  Date+Comparison.swift
//  CurrencyConverter
//
//  Created by Jevgenijs Jefrosinins on 18/12/2021.
//

import Foundation

extension Date {
    var isInHourIntervalWithCurrentTime: Bool {
        let currentDay = Calendar.current.dateComponents([.month, .day, .year], from: Date())
        let dayOfTheLastUpdate = Calendar.current.dateComponents([.month, .day, .year], from: self)
        let currentHour = Calendar.current.dateComponents([.hour], from: Date()).hour!
        let hourOfTheLastUpdate = Calendar.current.dateComponents([.hour], from: self).hour!

        return currentDay != dayOfTheLastUpdate || currentHour > hourOfTheLastUpdate
    }
}
