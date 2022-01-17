//
//  CurrencyListTableViewDataSource.swift
//  CurrencyConverter
//
//  Created by Jevgenijs Jefrosinins on 12/01/2022.
//

import UIKit

protocol CurrenciesListTableViewDataSourceDelegate: AnyObject {
    func currenciesListTableViewDataSource(_ currenciesListTableViewDataSource: CurrenciesListTableViewDataSource, didSelectedCurrency currency: Currency)
}

class CurrenciesListTableViewDataSource: NSObject, UITableViewDelegate {

    var sections: [Section] = []
    weak var delegate: CurrenciesListTableViewDataSourceDelegate?

    // MARK: - UITableView Delegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].currencyRates.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currency = sections[indexPath.section].currencyRates[indexPath.row].currency
        delegate?.currenciesListTableViewDataSource(self, didSelectedCurrency: currency)
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }
}

extension CurrenciesListTableViewDataSource: UITableViewDataSource {

    // MARK: - UITableView Data Source Methods
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sections[section].title
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CurrenciesListTableViewCell = tableView.dequeueReusableCell(for: indexPath)
        let section = sections[indexPath.section]
        let object = section.currencyRates[indexPath.row]
        cell.setCell(data: object)

        return cell
    }
}
