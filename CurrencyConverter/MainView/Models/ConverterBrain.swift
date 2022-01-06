//
//  ConverterBrain.swift
//  CurrencyConverter
//
//  Created by Jevgenijs Jefrosinins on 21/12/2021.
//

import Foundation

protocol ConverterBrainDelegate: AnyObject {
    func updateRates(rates: [CurrencyRate])
    func updateDate(date: Date)
    func showError(_ error: Error)
}

protocol ConverterBrainProtocol {
    var delegate: ConverterBrainDelegate? { get set }
    var baseCurrency: Currency { get set }
    var baseRate: Double { get set }
    var currentRates: [CurrencyRate] { get set }

    func updateData()
}

class ConverterBrain: ConverterBrainProtocol {

    weak var delegate: ConverterBrainDelegate?
    private let repository: RatesRepositoryProtocol
    private let requestedBaseCurrency = Currency.init(rawValue: "EUR")

    init(repository: RatesRepositoryProtocol) {
        self.repository = repository
    }

    var currentCurrencies: [Currency] = [Currency(rawValue: "USD"), Currency(rawValue: "EUR"), Currency(rawValue: "RUB"), Currency(rawValue: "CNY")]

    var currentRates: [CurrencyRate] = [] {
        didSet {
            delegate?.updateRates(rates: currentRates)
        }
    }

    var baseCurrency: Currency = .init(rawValue: "EUR") {
        didSet {
            changeBaseCurrency()
        }
    }

    var baseRate: Double = 1 {
        didSet {
            print(baseRate)
            convertRates()
        }
    }

    func updateData() {
        repository.fetchRates(currency: requestedBaseCurrency) { result in
            switch result {
            case let .success(rates):
                self.currentRates = rates.wrappedValue.filter { self.currentCurrencies.contains($0.currency) }
                self.delegate?.updateDate(date: rates.createdAt)
            case let .failure(error):
                self.delegate?.showError(error)
            }
        }
    }

    private func convertRates() {
        var rates = currentRates
        rates.indices.forEach {
            if rates[$0].currency != baseCurrency {
                rates[$0].rate *= baseRate
            }
        }
        currentRates = rates
    }

    private func changeBaseCurrency() {
        var rates = currentRates
        let currentBaseRate = rates.first {$0.currency == baseCurrency}!.rate
        rates.indices.forEach {
            let currentRate = rates[$0].rate
            rates[$0].base = baseCurrency
            if rates[$0].base != requestedBaseCurrency {
                rates[$0].rate = (1 / currentBaseRate) * currentRate
            } else {
                rates[$0].rate = currentRate / currentBaseRate
            }
        }
        currentRates = rates
    }
}
