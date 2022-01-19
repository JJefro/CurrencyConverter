//
//  RatesRemoteDataSource.swift
//  CurrencyConverter
//
//  Created by Jevgenijs Jefrosinins on 18/12/2021.
//

import Foundation

protocol RatesRemoteDataSourceProtocol {
    func fetchRates(baseCurrency: Currency, completion: @escaping (Result<[CurrencyRate], Error>) -> Void)
}

class RatesRemoteDataSource: RatesRemoteDataSourceProtocol {
    private let networkManager: NetworkManagerProtocol

    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }

    func fetchRates(baseCurrency: Currency, completion: @escaping (Result<[CurrencyRate], Error>) -> Void) {
        networkManager.getRatesFrom(baseCurrency) { result in
            switch result {
            case let .success(rates):
                completion(.success(rates.data))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
