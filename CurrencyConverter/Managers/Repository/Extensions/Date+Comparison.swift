//
//  Date+Comparison.swift
//  CurrencyConverter
//
//  Created by Jevgenijs Jefrosinins on 18/12/2021.
//

import Foundation

extension Date {
    var isInHourIntervalWithCurrentTime: Bool {
        let component: Calendar.Component = .hour
        return Calendar.current.dateComponents([component], from: self, to: Date()).value(for: component) == 0
    }
}
