//
//  CurrencyListViewController.swift
//  CurrencyConverter
//
//  Created by Jevgenijs Jefrosinins on 12/01/2022.
//

import UIKit

protocol CurrenciesListViewControllerDelegate: AnyObject {
    func currenciesListViewController(_ currenciesListViewController: CurrenciesListViewController, didSelectCurrency currency: Currency)
}

class CurrenciesListViewController: UIViewController {

    weak var delegate: CurrenciesListViewControllerDelegate?

    var tableView = CurrenciesListTableView()
    let searchController = UISearchController(searchResultsController: nil)
    var dataSource = CurrenciesListTableViewDataSource()
    var model = CurrenciesListBrain()

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

extension CurrenciesListViewController: UISearchBarDelegate {
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
        if let cell = tableView.visibleCells.first(where: { ($0 as! CurrencyListTableViewCell).currencyName.text!.contains(searchText) }),
            let indexPath = tableView.indexPath(for: cell) {
            tableView.scrollToRow(at: indexPath, at: .top, animated: true)
        } else {
            tableView.scrollToRow(at: IndexPath(row: 0, section: section), at: .top, animated: true)
        }
    }
}

extension CurrenciesListViewController: CurrencyListTableViewDataSourceDelegate {
    func currencyListTableViewDataSource(_ currencyListTableViewDataSource: CurrenciesListTableViewDataSource, didSelectedCurrency currency: Currency) {
        delegate?.currenciesListViewController(self, didSelectCurrency: currency)
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
        navigationController?.popToRootViewController(animated: true)
    }
}

extension CurrenciesListViewController: CurrencyListBrainDelegate {
    func currenciesListBrain(_ currenciesListBrain: CurrenciesListBrain, didSortCurrenciesIn sections: [Section]) {
        self.sections = sections
    }
}
