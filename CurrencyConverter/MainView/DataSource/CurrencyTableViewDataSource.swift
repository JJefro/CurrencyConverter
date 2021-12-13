//
//  CurrencyTableViewDatraSource.swift
//  CurrencyConverter
//
//  Created by Jevgenijs Jefrosinins on 05/12/2021.
//

import UIKit

class CurrencyTableViewDataSource: NSObject, UITableViewDelegate {

    var objects: [CurrencyRate] = []
    var model = CurrencyBrain()

    // MARK: - UITableView Delegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        objects.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let baseCurrency = objects[indexPath.row].currency
        model.baseCurrency = baseCurrency
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
