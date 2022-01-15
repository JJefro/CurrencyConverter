//
//  CurrencyListBrain.swift
//  CurrencyConverter
//
//  Created by Jevgenijs Jefrosinins on 13/01/2022.
//

import Foundation

protocol CurrencyListBrainDelegate: AnyObject {
    func currenciesListBrain(_ currencyListBrain: CurrenciesListBrain, didSortCurrenciesIn sections: [Section])
}

class CurrenciesListBrain { 

    weak var delegate: CurrencyListBrainDelegate?

    func sortCurrenciesIntoSections(_ currencies: [CurrencyRate]) {
        var arrayOfSections: [Section] = []

        var fetchedCurrencies = currencies
        let popularCurrencies = fetchedCurrencies.filter { CurrencyEntity.popularCurrencies.contains($0.currency) }
        fetchedCurrencies.removeAll(where: { popularCurrencies.contains($0)})

        let groupedDictionary = Dictionary(grouping: fetchedCurrencies) { String($0.locale.prefix(1)) }
        let keys = groupedDictionary.keys.sorted(by: { $0 < $1 })
        arrayOfSections = keys.map { Section(title: $0, currencyRates: groupedDictionary[$0]!.sorted(by: {$0.locale < $1.locale}))}
        arrayOfSections.insert(Section(title: R.string.localizable.currencyListView_firstSection_title(), currencyRates: popularCurrencies), at: 0)

        delegate?.currenciesListBrain(self, didSortCurrenciesIn: arrayOfSections)
    }
}
