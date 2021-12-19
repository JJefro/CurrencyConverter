//
//  RatesLocalDataSource.swift
//  CurrencyConverter
//
//  Created by Jevgenijs Jefrosinins on 18/12/2021.
//

import Foundation

protocol RatesLocalDataSourceProtocol: AnyObject {
    var rates: Timestamped<[CurrencyRate]>? { get set }
}

class RatesLocalDataSource: RatesLocalDataSourceProtocol {
    @CodableUserDefault(key: "com.jjefro.rates")
    var rates: Timestamped<[CurrencyRate]>?
}
