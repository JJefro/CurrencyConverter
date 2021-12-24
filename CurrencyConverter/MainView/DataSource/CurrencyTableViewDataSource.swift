//
//  CurrencyTableViewDatraSource.swift
//  CurrencyConverter
//
//  Created by Jevgenijs Jefrosinins on 05/12/2021.
//

import UIKit

protocol CurrencyTableViewDataSourceDelegate: AnyObject {
    func getBaseCurrency(currency: Currency)
}

class CurrencyTableViewDataSource: NSObject, UITableViewDelegate {

    var objects: [CurrencyRate] = []
    weak var delegate: CurrencyTableViewDataSourceDelegate?

    // MARK: - UITableView Delegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        objects.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let baseCurrency = objects[indexPath.row].currency
        let cell = tableView.cellForRow(at: indexPath) as! CurrencyTableViewCell
        print(cell.textFieldView.txtField.text!)
        DispatchQueue.main.async { [self] in
            delegate?.getBaseCurrency(currency: baseCurrency)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension CurrencyTableViewDataSource: UITableViewDataSource {

    // MARK: - UITableView Data Source Methods
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.identifier) as! CurrencyTableViewCell
        let object = objects[indexPath.row]
        cell.set(currency: object)
        cell.selectionStyle = .none
        return cell
    }
}
