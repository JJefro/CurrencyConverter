//
//  CurrencyTableViewDatraSource.swift
//  CurrencyConverter
//
//  Created by Jevgenijs Jefrosinins on 05/12/2021.
//

import UIKit

protocol TableViewDataSourceDelegate: AnyObject {
    func tableViewDataSource(_ tableViewDataSource: TableViewDataSource, currencyValueDidChange text: String, for currency: Currency)
}

class TableViewDataSource: NSObject, UITableViewDelegate {

    var objects: [CurrencyExchangeData] = []
    weak var delegate: TableViewDataSourceDelegate?
    
    // MARK: - UITableView Delegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        objects.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension TableViewDataSource: UITableViewDataSource {

    // MARK: - UITableView Data Source Methods
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.identifier) as! CurrencyTableViewCell
        cell.delegate = self
        let object = objects[indexPath.row]
        cell.updateCell(data: object)
        cell.selectionStyle = .none
        return cell
    }
}

extension TableViewDataSource: CurrencyTableViewCellDelegate {
    func currencyTableViewCell(_ currencyTableViewCell: CurrencyTableViewCell, currencyValueDidChange text: String, for currency: Currency) {
        delegate?.tableViewDataSource(self, currencyValueDidChange: text, for: currency)
    }
}
