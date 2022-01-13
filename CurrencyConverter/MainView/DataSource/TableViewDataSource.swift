//
//  CurrencyTableViewDatraSource.swift
//  CurrencyConverter
//
//  Created by Jevgenijs Jefrosinins on 05/12/2021.
//

import UIKit

protocol TableViewDataSourceDelegate: AnyObject {
    func tableViewDataSource(_ tableViewDataSource: TableViewDataSource, currencyValueDidChange text: String, for currency: Currency)
    func tableViewDataSource(_ tableViewDataSource: TableViewDataSource, currencyDidRemoved currency: Currency)
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

    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: nil) { _, _, completion in
            DispatchQueue.main.async { [self] in
                delegate?.tableViewDataSource(self, currencyDidRemoved: objects[indexPath.row].currency)
            }
            completion(true)
        }
        delete.image = R.image.trashImage()
        delete.backgroundColor = R.color.converterView.backgroundColor()
        return UISwipeActionsConfiguration(actions: [delete])
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
