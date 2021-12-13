//
//  Brain.swift
//  CurrencyConverter
//
//  Created by Jevgenijs Jefrosinins on 04/12/2021.
//

import Foundation

class CurrencyBrain {

    var baseCurrency: Currency = .USD {
        didSet {
            print(baseCurrency)
        }
    }
    
    private var network = NetworkManager()
    
    func getCurrentDataString() -> String {
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.timeStyle = .short
        formatter.dateStyle = .medium
        return formatter.string(from: currentDate)
    }
    
    func convert(completion: @escaping (CurrencyEntity) -> Void) {
        network.getRatesFrom(baseCurrency) { result in
            switch result {
            case let .success(currencyEntity):
                completion(currencyEntity)
            case let .failure(error):
                print(error)
            }
        }
    }
}
