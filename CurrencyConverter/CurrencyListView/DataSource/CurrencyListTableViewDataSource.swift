//
//  CurrencyListTableViewDataSource.swift
//  CurrencyConverter
//
//  Created by Jevgenijs Jefrosinins on 12/01/2022.
//

import UIKit

protocol CurrencyListTableViewDataSourceDelegate: AnyObject {
    func currencyListTableViewDataSource(_ currencyListTableViewDataSource: CurrencyListTableViewDataSource, didSelectedCurrency currency: Currency)
}

class CurrencyListTableViewDataSource: NSObject, UITableViewDelegate, UITableViewDataSource {

    var sections: [Section] = []
    weak var delegate: CurrencyListTableViewDataSourceDelegate?

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        sections[section].currencyRates.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currency = sections[indexPath.section].currencyRates[indexPath.row].currency
        delegate?.currencyListTableViewDataSource(self, didSelectedCurrency: currency)
        print("row - \(indexPath.row)")
        print("section - \(indexPath.section)")
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sections[section].title
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyListTableViewCell.identifier) as! CurrencyListTableViewCell

        let section = sections[indexPath.section]
        let object = section.currencyRates[indexPath.row]
        cell.setCell(data: object)

        return cell
    }
}
