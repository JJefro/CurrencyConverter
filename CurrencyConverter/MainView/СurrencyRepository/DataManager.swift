//
//  CurrencyRepository.swift
//  CurrencyConverter
//
//  Created by Jevgenijs Jefrosinins on 15/12/2021.
//

import Foundation

protocol RatesRepositoryProtocol {
    func fetchRates(currencies: [Currency], completion: @escaping (Result<Timestamped<[CurrencyRate]>, Error>) -> Void)
}

class DataManager: RatesRepositoryProtocol {
    private let localDataSource: RatesLocalDataSourceProtocol
    private let remoteDataSource: RatesRemoteDataSourceProtocol

    init(localDataSource: RatesLocalDataSourceProtocol, remoteDataSource: RatesRemoteDataSourceProtocol) {
        self.localDataSource = localDataSource
        self.remoteDataSource = remoteDataSource
    }

    func fetchRates(currencies: [Currency], completion: @escaping (Result<Timestamped<[CurrencyRate]>, Error>) -> Void) {
        if let localRates = localDataSource.rates, localRates.createdAt.isInMinuteIntervalWithCurrentTime {
            completion(.success(localRates))
        } else {
            remoteDataSource.fetchRates(currencies: currencies) { [localDataSource] result in
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
}
