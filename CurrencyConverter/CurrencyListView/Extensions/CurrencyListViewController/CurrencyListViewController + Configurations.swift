//
//  CurrencyListViewController + Configurations.swift
//  CurrencyConverter
//
//  Created by Jevgenijs Jefrosinins on 12/01/2022.
//

import Foundation
import SnapKit

extension CurrencyListViewController {

    func configure() {
        bind()
        configureTableView()
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
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.searchBarStyle = .prominent
        searchController.searchBar.placeholder = R.string.localizable.currencyListView_searchBar_placeholder()
        navigationItem.searchController = searchController
    }

    private func configureTableView() {
        tableView.rowHeight = 50
        tableView.backgroundColor = .clear

        tableView.separatorStyle = .singleLine
        tableView.separatorColor = R.color.mainView.backgroundColor()
        
        tableView.register(CurrencyListTableViewCell.self, forCellReuseIdentifier: CurrencyListTableViewCell.identifier)

        tableView.layer.masksToBounds = false
        tableView.layer.shadowRadius = 1
        tableView.layer.shadowOpacity = 1
        tableView.layer.shadowOffset = CGSize(width: 0, height: 4)
        tableView.layer.shadowColor = R.color.converterView.shadowColor()?.cgColor

        setTableViewConstraints()
    }

    private func setTableViewConstraints() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
