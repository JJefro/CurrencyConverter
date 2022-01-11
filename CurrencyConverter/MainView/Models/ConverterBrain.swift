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
}

protocol ConverterBrainProtocol {
    var delegate: ConverterBrainDelegate? { get set }
    var currentRates: [CurrencyExchangeData] { get set }

    func updateCurrencyRates()
    func calculateRates(value: String, currency: Currency)
}

struct CurrencyExchangeData {
    let currency: Currency
    let rate: Double
    var exchangeValue: Double?

    var exchangeValueString: String? {
        if let value = exchangeValue {
            return String(format: "%.2f", value)
        }
        return nil
    }
}

class ConverterBrain: ConverterBrainProtocol {

    weak var delegate: ConverterBrainDelegate?
    private let repository: RatesRepositoryProtocol
    private let requestedBaseCurrency = Currency.init(rawValue: "EUR")
    private var fetchedRates: [CurrencyRate] = []

    init(repository: RatesRepositoryProtocol) {
        self.repository = repository
    }

    var currentCurrencies: [Currency] = [Currency(rawValue: "USD"), Currency(rawValue: "EUR"), Currency(rawValue: "RUB"), Currency(rawValue: "CNY")]

    var currentRates: [CurrencyExchangeData] = [] {
        didSet {
            delegate?.converterBrain(self, didConvertRates: currentRates)
        }
    }

    func updateCurrencyRates() {
        delegate?.converterBrain(self, didUpdateLoading: true)
        repository.fetchRates(currency: requestedBaseCurrency) { result in
            switch result {
            case let .success(rates):
                self.fetchedRates = rates.wrappedValue.filter { self.currentCurrencies.contains($0.currency) }
                self.currentRates = self.fetchedRates.map { CurrencyExchangeData(currency: $0.currency, rate: $0.rate) }
                self.delegate?.converterBrain(self, didUpdateDate: rates.createdAt)
            case let .failure(error):
                self.delegate?.converterBrain(self, errorOccured: error)
            }
            self.delegate?.converterBrain(self, didUpdateLoading: false)
        }
    }

    func calculateRates(value: String, currency: Currency) {
        guard let currencyRate = fetchedRates.first(where: { $0.currency == currency }) else { return }
        let value = Double(value)
        currentRates = currentRates.map {
            var rate = $0
            if rate.currency == currency {
                rate.exchangeValue = value
            } else {
                rate.exchangeValue = value.map { $0 / currencyRate.rate * rate.rate }
            }
            return rate
        }
    }
}
