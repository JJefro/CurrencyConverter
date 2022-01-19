//
//  CurrencyConverterTests.swift
//  TextFieldsTests
//
//  Created by Jevgenijs Jefrosinins on 19/01/2022.
//

import XCTest
@testable import CurrencyConverter

class DateExtensionsTests: XCTestCase {

    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
    }

    func test_date_extension_isInHourIntervalWithCurrentTime() throws {
        let currentDate = Date()
        XCTAssertFalse(currentDate.isInHourIntervalWithCurrentTime)

        let currentMinutes = Calendar.current.dateComponents([.minute], from: currentDate).minute!

        if currentMinutes > 5 {
            let fiveMinutesBefore = Calendar.current.date(byAdding: .minute, value: -5, to: currentDate)!
            XCTAssertFalse(fiveMinutesBefore.isInHourIntervalWithCurrentTime)
        }

        let anHourAgo = Calendar.current.date(byAdding: .hour, value: -1, to: currentDate)!
        XCTAssertTrue(anHourAgo.isInHourIntervalWithCurrentTime)

        let oneDayAgo = Calendar.current.date(byAdding: .day, value: -1, to: currentDate)!
        XCTAssertTrue(oneDayAgo.isInHourIntervalWithCurrentTime)
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}
