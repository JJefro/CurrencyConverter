//
//  NetworkManagerMock.swift
//  CurrencyConverter
//
//  Created by Jevgenijs Jefrosinins on 19/01/2022.
//

import Foundation
@testable import CurrencyConverter

class NetworkManagerMock: NetworkManagerProtocol {

    let properties = PropertiesMock()
    var error: Error?

    let currencyEntityMock: CurrencyEntity

    init(mockCurrencyEntity: CurrencyEntity) {
        self.currencyEntityMock = mockCurrencyEntity
    }
    
    func getRatesFrom(_ baseCurrency: Currency, completion: @escaping CurrencyRatesCompletion) {
        performRequest(url: properties.url) { result in
            completion(result)
        }
    }

    func getHistoricalCurrencyRates(fromDate: String, toDate: String, baseCurrency: Currency, completion: @escaping CurrencyRatesCompletion) {
    }

    func performRequest(url: URL?, completion: @escaping RequestCompletion) {
        guard let error = error else {
            completion(.success(currencyEntityMock))
            return
        }
        completion(.failure(error))
    }
}
