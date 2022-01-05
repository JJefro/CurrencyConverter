//
//  RatesRemoteDataSource.swift
//  CurrencyConverter
//
//  Created by Jevgenijs Jefrosinins on 18/12/2021.
//

import Foundation

protocol RatesRemoteDataSourceProtocol {
    func fetchRates(currency: Currency, completion: @escaping (Result<[CurrencyRate], Error>) -> Void)
}

class RatesRemoteDataSource: RatesRemoteDataSourceProtocol {
    private let networkManager: NetworkManagerProtocol

    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }

    func fetchRates(currency: Currency, completion: @escaping (Result<[CurrencyRate], Error>) -> Void) {
        networkManager.getRatesFrom(currency) { result in
            switch result {
            case let .success(rate):
                completion(.success(rate.data))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
