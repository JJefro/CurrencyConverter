//
//  RatesRemoteDataSource.swift
//  CurrencyConverter
//
//  Created by Jevgenijs Jefrosinins on 18/12/2021.
//

import Foundation

protocol RatesRemoteDataSourceProtocol {
    func fetchRates(completion: @escaping (Result<[CurrencyRate], Error>) -> Void)
}

class RatesRemoteDataSource: RatesRemoteDataSourceProtocol {
    private let networkManager: NetworkManagerProtocol

    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }

    func fetchRates(completion: @escaping (Result<[CurrencyRate], Error>) -> Void) {
        networkManager.getRatesFrom(Currency.init(rawValue: "USD")) { result in
            switch result {
            case let .success(entity):
                print(entity.data)
                completion(.success(entity.data))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}
