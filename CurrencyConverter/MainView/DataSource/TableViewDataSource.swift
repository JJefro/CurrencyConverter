//
//  CurrencyTableViewDatraSource.swift
//  CurrencyConverter
//
//  Created by Jevgenijs Jefrosinins on 05/12/2021.
//

import UIKit

protocol TableViewDataSourceDelegate: AnyObject {
    func tableViewDataSource(_ tableViewDataSource: TableViewDataSource, didChangeBaseCurrency currency: Currency)
}

class TableViewDataSource: NSObject, UITableViewDelegate {

    var objects: [CurrencyRate] = []
    weak var delegate: TableViewDataSourceDelegate?
    
    // MARK: - UITableView Delegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        objects.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let baseCurrency = objects[indexPath.row].currency
        delegate?.tableViewDataSource(self, didChangeBaseCurrency: baseCurrency)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension TableViewDataSource: UITableViewDataSource {

    // MARK: - UITableView Data Source Methods
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.identifier) as! CurrencyTableViewCell
        let object = objects[indexPath.row]
        cell.set(currency: object)
        cell.selectionStyle = .none
        return cell
    }
}
