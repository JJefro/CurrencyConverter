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
        networkManagerMock = NetworkManagerMock(currencyDataMock: .currencyRatesDataMock)
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

        model.saveCurrency(Currency(rawValue: "AUD"))
        var trackedCurrencies = properties.trackedCurrencies
        trackedCurrencies.append(Currency(rawValue: "AUD"))
        XCTAssertEqual(model.trackedCurrencies, trackedCurrencies)

        model.deleteCurrency(Currency(rawValue: "AUD"))
        XCTAssertEqual(model.trackedCurrencies, properties.trackedCurrencies)
    }

    func test_model_ratesCalculations_shekel() throws {
        model.updateCurrencyRates()
        model.calculateRates(value: "100", currency: Currency.init(rawValue: "ILS"))

        let expectedOutputILStoEUR = "28.14"
        let euro = model.currentRates.first(where: {$0.currency == Currency(rawValue: "EUR") })!
        XCTAssertEqual(euro.exchangeValueString, expectedOutputILStoEUR)

        let expectedOutputILStoRUB = "2434.90"
        let ruble = model.currentRates.first(where: { $0.currency == Currency(rawValue: "RUB") })!
        XCTAssertEqual(ruble.exchangeValueString, expectedOutputILStoRUB)

        let expectedOutputILStoUSD = "31.93"
        let usdDollar = model.currentRates.first(where: { $0.currency == Currency(rawValue: "USD") })!
        XCTAssertEqual(usdDollar.exchangeValueString, expectedOutputILStoUSD)
    }

    func test_model_ratesCalculations_usDollar() throws {
        model.updateCurrencyRates()
        model.calculateRates(value: "100", currency: Currency.init(rawValue: "USD"))

        let expectedOutputUSDtoEUR = "88.11"
        let euro = model.currentRates.first(where: {$0.currency == Currency(rawValue: "EUR") })!
        XCTAssertEqual(euro.exchangeValueString, expectedOutputUSDtoEUR)

        let expectedOutputUSDtoRUB = "7624.89"
        let ruble = model.currentRates.first(where: { $0.currency == Currency(rawValue: "RUB") })!
        XCTAssertEqual(ruble.exchangeValueString, expectedOutputUSDtoRUB)

        let expectedOutputUSDtoILS = "313.15"
        let shekel = model.currentRates.first(where: { $0.currency == Currency(rawValue: "ILS") })!
        XCTAssertEqual(shekel.exchangeValueString, expectedOutputUSDtoILS)
    }
}
