//
//  CurrenciesListTableView.swift
//  CurrencyConverter
//
//  Created by Jevgenijs Jefrosinins on 14/01/2022.
//

import Foundation
import UIKit

class CurrenciesListTableView: UITableView {

    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: .insetGrouped)

        rowHeight = 50
        register(CurrenciesListTableViewCell.self, forCellReuseIdentifier: CurrenciesListTableViewCell.reuseIdentifier)

        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        separatorStyle = .singleLine
        separatorColor = R.color.mainView.backgroundColor()
        separatorInset = .init(top: 0, left: 20, bottom: 0, right: 20)

        backgroundColor = .clear
        layer.masksToBounds = false
        layer.shadowRadius = 1
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowColor = R.color.converterView.shadowColor()?.cgColor
    }
}
