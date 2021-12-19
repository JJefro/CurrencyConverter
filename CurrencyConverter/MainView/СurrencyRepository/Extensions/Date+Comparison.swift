//
//  Date+Comparison.swift
//  CurrencyConverter
//
//  Created by Jevgenijs Jefrosinins on 18/12/2021.
//

import Foundation

extension Date {
    var isInMinuteIntervalWithCurrentTime: Bool {
        let component: Calendar.Component = .minute
        return Calendar.current.dateComponents([component], from: self, to: Date()).value(for: component) == 0
    }
}
