//
//  Brain.swift
//  CurrencyConverter
//
//  Created by Jevgenijs Jefrosinins on 04/12/2021.
//

import Foundation

class Brain {

    private var network = NetworkManager()

    func getCurrentDataString() -> String {
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .medium
        return formatter.string(from: currentDate)
    }

    func convertCurrencies(currency: Currency, toCurrency: Currency, completion: @escaping () -> Void) {
        network.getCurrencyRatesFrom(baseCurrency: currency) { result in
            switch result {
            case let .success(result):
                if let currency = result.data[String(describing: toCurrency)] {
                    print(currency)
                }
            case let .failure(error):
                print(error)
            }
        }
    }
}
