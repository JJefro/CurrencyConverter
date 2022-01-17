//
//  CurrencyListViewController + Configurations.swift
//  CurrencyConverter
//
//  Created by Jevgenijs Jefrosinins on 12/01/2022.
//

import Foundation
import SnapKit

extension CurrenciesListViewController {

    func configure() {
        bind()
        setTableViewConstraints()
        configureSearchController()

        view.backgroundColor = R.color.mainView.backgroundColor()
        self.navigationController?.navigationBar.topItem?.backButtonTitle = R.string.localizable.currencyListView_navBar_backButtonTitle()
        title = R.string.localizable.currencyListView_navBar_title()
    }

    private func bind() {
        tableView.delegate = dataSource
        tableView.dataSource = dataSource
        dataSource.delegate = self
        searchController.searchBar.delegate = self
        model.delegate = self
    }

    private func configureSearchController() {
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.searchBarStyle = .prominent
        searchController.searchBar.placeholder = R.string.localizable.currencyListView_searchBar_placeholder()
        navigationItem.searchController = searchController
    }

    private func setTableViewConstraints() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
