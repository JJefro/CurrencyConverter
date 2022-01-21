//
//  DateTests.swift
//  TextFieldsTests
//
//  Created by Jevgenijs Jefrosinins on 19/01/2022.
//

import XCTest
@testable import CurrencyConverter

class DateTests: XCTestCase {

    func test_date_isInHourIntervalWithCurrentTime() throws {

        let currentDateRoundedToMinutes = Calendar.current.dateComponents([.minute, .hour, .day, .month, .year], from: Date()).minute!

        if currentDateRoundedToMinutes > 5 {
            let fourMinutesAgo = Calendar.current.date(byAdding: .minute, value: -4, to: Date())!
            XCTAssertTrue(fourMinutesAgo.isInHourIntervalWithCurrentTime)
        }

        if currentDateRoundedToMinutes < 20 {
            let halfAnHourAgo = Calendar.current.date(byAdding: .minute, value: -30, to: Date())!
            XCTAssertFalse(halfAnHourAgo.isInHourIntervalWithCurrentTime)
        }

        let twoHoursAgo = Calendar.current.date(byAdding: .hour, value: -2, to: Date())!
        XCTAssertFalse(twoHoursAgo.isInHourIntervalWithCurrentTime)

        let oneDayAgo = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        XCTAssertFalse(oneDayAgo.isInHourIntervalWithCurrentTime)

        let oneYearAgo = Calendar.current.date(byAdding: .year, value: -1, to: Date())!
        XCTAssertFalse(oneYearAgo.isInHourIntervalWithCurrentTime)
    }
}
