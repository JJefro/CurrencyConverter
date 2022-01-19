//
//  CurrencyListBrain.swift
//  CurrencyConverter
//
//  Created by Jevgenijs Jefrosinins on 13/01/2022.
//

import Foundation

protocol CurrenciesListBrainDelegate: AnyObject {
    func currenciesListBrain(_ currencyListBrain: CurrenciesListBrain, didSortCurrenciesIn sections: [Section])
}

protocol CurrenciesListBrainProtocol {
    var delegate: CurrenciesListBrainDelegate? { get set }
    var sections: [Section] { get }

    func filterCurrencies(_ currencies: [CurrencyRate], by text: String)
    func sortCurrenciesInSections(_ currencies: [CurrencyRate])
}

class CurrenciesListBrain: CurrenciesListBrainProtocol { 

    weak var delegate: CurrenciesListBrainDelegate?

    var sections: [Section] = [] {
        didSet {
            delegate?.currenciesListBrain(self, didSortCurrenciesIn: sections)
        }
    }

    func filterCurrencies(_ currencies: [CurrencyRate], by text: String) {
        if !text.isEmpty {
            let searchText = text.lowercased()

            var filteredByLocale = currencies.filter { $0.locale.lowercased().contains(searchText) }
            let filteredByTitle = currencies.filter { $0.currency.rawValue.lowercased().contains(searchText) }

            filteredByLocale.removeAll(where: { filteredByTitle.contains($0) })

            let filteredCurrencies: [CurrencyRate] = filteredByTitle + filteredByLocale
            sortCurrenciesInSections(filteredCurrencies)
        } else {
            sortCurrenciesInSections(currencies)
        }
    }

    func sortCurrenciesInSections(_ currencies: [CurrencyRate]) {
        var arrayOfSections: [Section] = []

        var fetchedCurrencies = currencies
        let popularCurrencies = fetchedCurrencies.filter { CurrencyEntity.popularCurrencies.contains($0.currency) }
        fetchedCurrencies.removeAll(where: { popularCurrencies.contains($0)})

        let groupedDictionary = Dictionary(grouping: fetchedCurrencies) { String($0.locale.prefix(1)) }
        let keys = groupedDictionary.keys.sorted(by: { $0 < $1 })
        arrayOfSections = keys.map { Section(title: $0, currencyRates: groupedDictionary[$0]!.sorted(by: { $0.locale < $1.locale })) }

        if !popularCurrencies.isEmpty {
            arrayOfSections.insert(Section(title: R.string.localizable.currencyListView_firstSection_title(), currencyRates: popularCurrencies), at: 0)
        }
        sections = arrayOfSections
    }
}
