//
//  CurrenciesListViewController + AccessibilityIdentifiers.swift
//  CurrencyConverter
//
//  Created by Jevgenijs Jefrosinins on 21/01/2022.
//

import Foundation

extension CurrenciesListViewController {

    func setAccessibilityIdentifiers() {
        view.accessibilityIdentifier = CurrenciesListViewAccessibilityID.currenciesListView

        searchController.searchBar.accessibilityIdentifier = CurrenciesListViewAccessibilityID.searchBar
        searchController.searchBar.searchTextField.accessibilityIdentifier = CurrenciesListViewAccessibilityID.searchTextField

        tableView.accessibilityIdentifier = CurrenciesListViewAccessibilityID.tableView
    }
}
