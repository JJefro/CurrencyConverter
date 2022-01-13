//
//  CurrencyRepository.swift
//  CurrencyConverter
//
//  Created by Jevgenijs Jefrosinins on 15/12/2021.
//

import Foundation

protocol RatesRepositoryProtocol {
    func fetchRates(currency: Currency, completion: @escaping (Result<Timestamped<[CurrencyRate]>, Error>) -> Void)
    func loadTrackedCurrencies(completion: @escaping ([Currency]) -> Void)
    func saveCurrency(currency: Currency)
    func deleteCurrency(_ currency: Currency)
}

class DataManager: RatesRepositoryProtocol {
    private let localDataSource: RatesLocalDataSourceProtocol
    private let remoteDataSource: RatesRemoteDataSourceProtocol

    init(localDataSource: RatesLocalDataSourceProtocol, remoteDataSource: RatesRemoteDataSourceProtocol) {
        self.localDataSource = localDataSource
        self.remoteDataSource = remoteDataSource
    }

    func fetchRates(currency: Currency, completion: @escaping (Result<Timestamped<[CurrencyRate]>, Error>) -> Void) {
        if let localRates = localDataSource.rates, localRates.createdAt.isInHourIntervalWithCurrentTime {
            completion(.success(localRates))
        } else {
            remoteDataSource.fetchRates(currency: currency) { [localDataSource] result in
                switch result.map({ Timestamped(wrappedValue: $0) }) {
                case let .success(rates):
                    localDataSource.rates = rates
                    completion(.success(rates))
                case let .failure(error):
                    completion(.failure(error))
                }
            }
        }
    }

    func saveCurrency(currency: Currency) {
        localDataSource.trackedCurrencies?.append(currency)
    }

    func deleteCurrency(_ currency: Currency) {
        localDataSource.trackedCurrencies?.removeAll(where: { $0 == currency })
    }

    func loadTrackedCurrencies(completion: @escaping ([Currency]) -> Void) {
        if let currencies = localDataSource.trackedCurrencies, !currencies.isEmpty {
            completion(currencies)
        } else {
            let initialCurrencies = CurrencyEntity.initialCurrencies
            localDataSource.trackedCurrencies = initialCurrencies
            completion(initialCurrencies)
        }
    }
}
