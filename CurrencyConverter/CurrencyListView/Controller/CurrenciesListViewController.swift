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

    var model: CurrenciesListBrainProtocol = CurrenciesListBrain()

    var currencies: [CurrencyRate] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.largeTitleDisplayMode = .never
        configure()
        getSectionsFromCurrencies()
        setAccessibilityIdentifiers()
    }

    private func getSectionsFromCurrencies() {
        model.sortCurrenciesInSections(currencies)
    }
}

// MARK: - UISearchBar Delegate Methods
extension CurrenciesListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        model.filterCurrencies(currencies, by: searchText)
    }
}

// MARK: - CurrenciesListTableViewDataSource Delegate Methods
extension CurrenciesListViewController: CurrenciesListTableViewDataSourceDelegate {
    func currenciesListTableViewDataSource(_ currencyListTableViewDataSource: CurrenciesListTableViewDataSource, didSelectedCurrency currency: Currency) {
        navigationController?.popToRootViewController(animated: true)
        delegate?.currenciesListViewController(self, didSelectCurrency: currency)
    }
}

// MARK: - CurrenciesListBrain Delegate Methods
extension CurrenciesListViewController: CurrenciesListBrainDelegate {
    func currenciesListBrain(_ currenciesListBrain: CurrenciesListBrain, didSortCurrenciesIn sections: [Section]) {
        dataSource.sections = sections
        tableView.reloadData()
    }
}
