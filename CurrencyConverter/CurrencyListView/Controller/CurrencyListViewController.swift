//
//  CurrencyListViewController.swift
//  CurrencyConverter
//
//  Created by Jevgenijs Jefrosinins on 12/01/2022.
//

import UIKit

protocol CurrencyListViewControllerDelegate: NSObjectProtocol {
    func currencyListViewController(_ currencyListViewController: CurrencyListViewController, didSelectedCurrency currency: Currency)
}

class CurrencyListViewController: UIViewController {

    weak var delegate: CurrencyListViewControllerDelegate?

    var tableView = UITableView(frame: .zero, style: .insetGrouped)
    let searchController = UISearchController(searchResultsController: nil)
    var dataSource = CurrencyListTableViewDataSource()
    var model = CurrencyListBrain()

    var currencies: [CurrencyRate] = []

    private var sections: [Section] = [] {
        didSet {
            dataSource.sections = sections
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.largeTitleDisplayMode = .never
        getSectionsFromCurrencies()
    }

    private func getSectionsFromCurrencies() {
        model.sortCurrenciesIntoSections(currencies)
    }
}

extension CurrencyListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {

        var section = 0
        if !sections[0].currencyRates.contains(where: { $0.locale.contains(searchText) }) {
            if let index = sections.firstIndex(where: { $0.title.contains(searchText.prefix(1)) }) {
                section = index
                tableView.scrollToRow(at: IndexPath(row: 0, section: section), at: .top, animated: true)
            } else {
                tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
            }
        }

        if let cell = tableView.visibleCells.first(where: { ($0 as! CurrencyListTableViewCell).currencyName.text!.contains(searchText)}) {
            if let indexPath = tableView.indexPath(for: cell) {
                tableView.scrollToRow(at: indexPath, at: .top, animated: true)
            } else {
                tableView.scrollToRow(at: IndexPath(row: 0, section: section), at: .top, animated: true)
            }
        } else {
            tableView.scrollToRow(at: IndexPath(row: 0, section: section), at: .top, animated: true)
        }
    }
}

extension CurrencyListViewController: CurrencyListTableViewDataSourceDelegate {
    func currencyListTableViewDataSource(_ currencyListTableViewDataSource: CurrencyListTableViewDataSource, didSelectedCurrency currency: Currency) {
        delegate?.currencyListViewController(self, didSelectedCurrency: currency)
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        navigationController?.popToRootViewController(animated: true)
    }
}

extension CurrencyListViewController: CurrencyListBrainDelegate {
    func currencyListBrain(_ currencyListBrain: CurrencyListBrain, didSortedCurrenciesInto sections: [Section]) {
        self.sections = sections
    }
}
