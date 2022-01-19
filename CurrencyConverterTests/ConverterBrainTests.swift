//
//  ConverterBrainTests.swift
//  TextFieldsTests
//
//  Created by Jevgenijs Jefrosinins on 19/01/2022.
//

import XCTest
@testable import CurrencyConverter

class ConverterBrainTests: XCTestCase {

        private var properties = PropertiesMock()

        private var networkManagerMock: NetworkManagerProtocol!
        private var ratesRemoteDataSource: RatesRemoteDataSourceProtocol!
        private var ratesLocalDataSourceMock: RatesLocalDataSourceProtocol!
        private var dataManagerMock: RatesRepositoryProtocol!
        private var model: ConverterBrainProtocol!

        override func setUpWithError() throws {
            networkManagerMock = NetworkManagerMock(mockCurrencyEntity: .currencyRatesMock)
            ratesRemoteDataSource = RatesRemoteDataSource(networkManager: networkManagerMock)
            ratesLocalDataSourceMock = RatesLocalDataSourceMock()

            dataManagerMock = DataManagerMock(remoteDataSource: ratesRemoteDataSource, localDataSourceMock: ratesLocalDataSourceMock)
            model = ConverterBrain(repository: dataManagerMock)
            
            try super.setUpWithError()
        }

        override func tearDownWithError() throws {
            model = nil
            dataManagerMock = nil
            ratesRemoteDataSource = nil
            ratesLocalDataSourceMock = nil
            networkManagerMock = nil
        }

        func test_model_trackedCurrencies() throws {
            model.updateCurrencyRates()
            XCTAssertEqual(model.trackedCurrencies, properties.trackedCurrencies)

            model.saveCurrency(Currency(rawValue: "ILS"))
            var trackedCurrencies = properties.trackedCurrencies
            trackedCurrencies.append(Currency(rawValue: "ILS"))
            XCTAssertEqual(model.trackedCurrencies, trackedCurrencies)

            model.deleteCurrency(Currency(rawValue: "ILS"))
            XCTAssertEqual(model.trackedCurrencies, properties.trackedCurrencies)
        }

        func test_model_ratesCalculations() throws {
            model.updateCurrencyRates()

            model.calculateRates(value: "1000", currency: Currency.init(rawValue: "ILS"))
            let expectedOutputEUR = "28.14"
            let euro = model.currentRates.first(where: {$0.currency == Currency(rawValue: "EUR") })
            XCTAssertEqual(euro?.exchangeValueString, expectedOutputEUR)

            let expectedOutputRUB = "2434.90"
            let ruble = model.currentRates.first(where: { $0.currency == Currency(rawValue: "RUB") })
            XCTAssertEqual(ruble?.exchangeValueString, expectedOutputRUB)

            let expectedOutputUSD = "31.93"
            let usdDollar = model.currentRates.first(where: { $0.currency == Currency(rawValue: "USD") })
            XCTAssertEqual(usdDollar?.exchangeValueString, expectedOutputUSD)
        }

        func testPerformanceExample() throws {
            // This is an example of a performance test case.
            self.measure {
                // Put the code you want to measure the time of here.
            }
        }
    }
