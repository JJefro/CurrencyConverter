//
//  ConverterBrain.swift
//  CurrencyConverter
//
//  Created by Jevgenijs Jefrosinins on 21/12/2021.
//

import Foundation

typealias CompletionHandler = (Result<(String, [CurrencyRate]), Error>) -> Void

protocol ConverterBrainProtocol {
    func updateData(completion: @escaping CompletionHandler)
    func filterRates(_ rates: Timestamped<[CurrencyRate]>) -> [CurrencyRate]
    var baseCurrency: Currency { get set }
}

class ConverterBrain: ConverterBrainProtocol {

    private let repository: RatesRepositoryProtocol

    init(repository: RatesRepositoryProtocol) {
        self.repository = repository
    }

    var baseCurrency: Currency = .init(rawValue: "EUR")
    var currentCurrencies: [Currency] = [Currency(rawValue: "USD"), Currency(rawValue: "EUR"), Currency(rawValue: "RUB"), Currency(rawValue: "CNY")]

    func updateData(completion: @escaping CompletionHandler) {
        repository.fetchRates(currencies: currentCurrencies) { [self] result in
            switch result {
            case let .success(rates):
                let date = rates.createdAt.formatted(date: .abbreviated, time: .shortened)
                let filteredRates = filterRates(rates)
                DispatchQueue.main.async {
                    completion(.success((date, filteredRates)))
                }
            case let .failure(error):
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
            }
        }
    }

    func filterRates(_ rates: Timestamped<[CurrencyRate]>) -> [CurrencyRate] {
        let filteredRates = rates.wrappedValue.filter { $0.base == self.baseCurrency }
        return filteredRates.filter {self.currentCurrencies.contains($0.currency)}
    }
}
