//
//  DataManagerMock.swift
//  TextFieldsTests
//
//  Created by Jevgenijs Jefrosinins on 19/01/2022.
//

import Foundation
@testable import CurrencyConverter

class DataManagerMock: RatesRepositoryProtocol {

    private var propetries = PropertiesMock()

    let remoteDataSource: RatesRemoteDataSourceProtocol
    let localDataSourceMock: RatesLocalDataSourceProtocol

    init(remoteDataSource: RatesRemoteDataSourceProtocol, localDataSourceMock: RatesLocalDataSourceProtocol) {
        self.remoteDataSource = remoteDataSource
        self.localDataSourceMock = localDataSourceMock
    }

    func fetchRates(currency: Currency, completion: @escaping (Result<Timestamped<[CurrencyRate]>, Error>) -> Void) {
        remoteDataSource.fetchRates(baseCurrency: currency) { result in
            switch result.map({ Timestamped(wrappedValue: $0 )}) {
            case let .success(rates):
                completion(.success(rates))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    func loadTrackedCurrencies(completion: @escaping ([Currency]) -> Void) {
        if let trackedCurrencies = localDataSourceMock.trackedCurrencies, !trackedCurrencies.isEmpty {
            completion(trackedCurrencies)
        } else {
            localDataSourceMock.trackedCurrencies = propetries.trackedCurrencies
            completion(propetries.trackedCurrencies)
        }
    }

    func saveCurrency(_ currency: Currency) {
        localDataSourceMock.trackedCurrencies?.append(currency)
    }

    func deleteCurrency(_ currency: Currency) {
        localDataSourceMock.trackedCurrencies?.removeAll(where: { $0 == currency })
    }
}
