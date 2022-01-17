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

        self.rowHeight = 50
        self.register(CurrenciesListTableViewCell.self, forCellReuseIdentifier: CurrenciesListTableViewCell.reuseIdentifier)
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        self.separatorStyle = .singleLine
        self.separatorColor = R.color.mainView.backgroundColor()
        self.separatorInset = .init(top: 0, left: 20, bottom: 0, right: 20)

        self.backgroundColor = .clear
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 1
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: 0, height: 4)
        self.layer.shadowColor = R.color.converterView.shadowColor()?.cgColor
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
