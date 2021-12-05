//
//  CurrencyTableViewDatraSource.swift
//  CurrencyConverter
//
//  Created by Jevgenijs Jefrosinins on 05/12/2021.
//

import UIKit

class CurrencyTableViewDatraSource: NSObject, UITableViewDelegate {

    let objects: [String] = ["USD", "EUR", "RUB"]

    // MARK: - UITableView Delegate Methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        objects.count
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension CurrencyTableViewDatraSource: UITableViewDataSource {

    // MARK: - UITableView Data Source Methods
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CurrencyTableViewCell.identifier) as! CurrencyTableViewCell
        let object = objects[indexPath.row]
        cell.set(currency: object)
        return cell
    }
}
