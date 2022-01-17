//
//  CurrencyListViewController.swift
//  CurrencyConverter
//
//  Created by Jevgenijs Jefrosinins on 12/01/2022.
//

import UIKit
import Speech

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

    private var sections: [Section] = [] {
        didSet {
            dataSource.sections = sections
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.largeTitleDisplayMode = .never
        configure()
        getSectionsFromCurrencies()
    }

    private func getSectionsFromCurrencies() {
        model.sortCurrenciesInSections(currencies)
    }
}

extension CurrenciesListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        model.filterCurrencies(currencies, by: searchText)
    }

    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
    }
}

extension CurrenciesListViewController: CurrencyListTableViewDataSourceDelegate {
    func currencyListTableViewDataSource(_ currencyListTableViewDataSource: CurrenciesListTableViewDataSource, didSelectedCurrency currency: Currency) {
        navigationController?.popToRootViewController(animated: true)
        delegate?.currenciesListViewController(self, didSelectCurrency: currency)
    }
}

extension CurrenciesListViewController: CurrencyListBrainDelegate {
    func currenciesListBrain(_ currenciesListBrain: CurrenciesListBrain, didSortCurrenciesIn sections: [Section]) {
        self.sections = sections
    }
}
