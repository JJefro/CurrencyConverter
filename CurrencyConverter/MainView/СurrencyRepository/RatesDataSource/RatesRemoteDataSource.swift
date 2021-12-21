//
//  RatesRemoteDataSource.swift
//  CurrencyConverter
//
//  Created by Jevgenijs Jefrosinins on 18/12/2021.
//

import Foundation

protocol RatesRemoteDataSourceProtocol {
    func fetchRates(currencies: [Currency], completion: @escaping (Result<[CurrencyRate], Error>) -> Void)
}

class RatesRemoteDataSource: RatesRemoteDataSourceProtocol {
    private let networkManager: NetworkManagerProtocol

    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }

    func fetchRates(currencies: [Currency], completion: @escaping (Result<[CurrencyRate], Error>) -> Void) {
        var rates = [CurrencyRate]()
        var count = 0
        for currency in currencies {
            count += 1
            networkManager.getRatesFrom(currency) { result in
                switch result {
                case let .success(rate):
                    rates.append(contentsOf: rate.data)
                    if count == currencies.count {
                        completion(.success(rates))
                    }
                case let .failure(error):
                    completion(.failure(error))
                }
            }
        }
    }

}
