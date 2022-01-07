//
//  ConverterBrain.swift
//  CurrencyConverter
//
//  Created by Jevgenijs Jefrosinins on 21/12/2021.
//

import Foundation

protocol ConverterBrainDelegate: AnyObject {
    func converterBrain(_ converterBrain: ConverterBrainProtocol, didUpdateRates rates: [CurrencyRate])
    func converterBrain(_ converterBrain: ConverterBrainProtocol, didUpdateDate date: Date)
    func converterBrain(_ converterBrain: ConverterBrainProtocol, errorOccured error: Error)
    func converterBrain(_ converterBrain: ConverterBrainProtocol, didUpdateLoading isLoading: Bool)
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
            delegate?.converterBrain(self, didUpdateRates: currentRates)
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
        delegate?.converterBrain(self, didUpdateLoading: true)
        repository.fetchRates(currency: requestedBaseCurrency) { result in
            switch result {
            case let .success(rates):
                self.currentRates = rates.wrappedValue.filter { self.currentCurrencies.contains($0.currency) }
                self.delegate?.converterBrain(self, didUpdateDate: rates.createdAt)
            case let .failure(error):
                self.delegate?.converterBrain(self, errorOccured: error)
            }
            self.delegate?.converterBrain(self, didUpdateLoading: false)
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
