//
//  ConverterBrain.swift
//  CurrencyConverter
//
//  Created by Jevgenijs Jefrosinins on 21/12/2021.
//

import Foundation

protocol ConverterBrainDelegate: AnyObject {
    func converterBrain(_ converterBrain: ConverterBrainProtocol, didConvertRates rates: [CurrencyExchangeData])
    func converterBrain(_ converterBrain: ConverterBrainProtocol, didUpdateDate date: Date)
    func converterBrain(_ converterBrain: ConverterBrainProtocol, errorOccured error: Error)
    func converterBrain(_ converterBrain: ConverterBrainProtocol, didUpdateLoading isLoading: Bool)
    func converterBrain(_ converterBrain: ConverterBrainProtocol, didFetchCurrencies rates: [CurrencyRate])
}

protocol ConverterBrainProtocol {
    var delegate: ConverterBrainDelegate? { get set }
    var currentRates: [CurrencyExchangeData] { get set }

    func updateCurrencyRates()
    func saveCurrency(_ currency: Currency)
    func deleteCurrency(_ currency: Currency)
    func calculateRates(value: String, currency: Currency)
}

class ConverterBrain: ConverterBrainProtocol {

    weak var delegate: ConverterBrainDelegate?
    private let repository: RatesRepositoryProtocol
    private let requestedBaseCurrency = Currency.init(rawValue: "EUR")
    private var trackedCurrencies: [Currency] = []
    private var fetchedRates: [CurrencyRate] = [] {
        didSet {
            let rates = fetchedRates.filter { trackedCurrencies.contains($0.currency) }
            currentRates = rates.map { CurrencyExchangeData(currency: $0.currency, rate: $0.rate) }
            delegate?.converterBrain(self, didFetchCurrencies: fetchedRates)
        }
    }

    var currentRates: [CurrencyExchangeData] = [] {
        didSet {
            delegate?.converterBrain(self, didConvertRates: currentRates)
        }
    }

    init(repository: RatesRepositoryProtocol) {
        self.repository = repository
    }

    func updateCurrencyRates() {
        delegate?.converterBrain(self, didUpdateLoading: true)
        loadTrackedCurrencies()
        repository.fetchRates(currency: requestedBaseCurrency) { [self] result in
            switch result {
            case let .success(rates):
                fetchedRates = rates.wrappedValue
                delegate?.converterBrain(self, didUpdateDate: rates.createdAt)
            case let .failure(error):
                delegate?.converterBrain(self, errorOccured: error)
            }
            delegate?.converterBrain(self, didUpdateLoading: false)
        }
    }

    func calculateRates(value: String, currency: Currency) {
        guard let currencyRate = fetchedRates.first(where: { $0.currency == currency }) else { return }
        let value = Double(value)
        currentRates = currentRates.map {
            var data = $0
            if data.currency == currency {
                data.exchangeValue = value
            } else {
                data.exchangeValue = value.map { $0 / currencyRate.rate * data.rate }
            }
            return data
        }
    }

    func deleteCurrency(_ currency: Currency) {
        repository.deleteCurrency(currency)
        updateCurrencyRates()
    }

    func saveCurrency(_ currency: Currency) {
        repository.saveCurrency(currency)
        updateCurrencyRates()
    }
    
    private func loadTrackedCurrencies() {
        repository.loadTrackedCurrencies { [self] currencies in
            trackedCurrencies = currencies
        }
    }
}
