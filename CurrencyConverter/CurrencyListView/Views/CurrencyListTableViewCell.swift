//
//  CurrencyListTableViewCell.swift
//  CurrencyConverter
//
//  Created by Jevgenijs Jefrosinins on 12/01/2022.
//

import UIKit
import SnapKit

class CurrencyListTableViewCell: UITableViewCell {

    static let identifier = "CurrencyListTableViewCell"

    private var currencyCode = UILabel()
    var currencyName = UILabel()
    private var horizontalStack = UIStackView()

    private let separator: UILabel = {
        var label = UILabel()
        label.text = "-"
        label.font = R.font.sfProDisplayRegular(size: 17)
        label.textColor = R.color.mainView.textColor()
        label.textAlignment = .center
        return label
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(currencyCode)
        contentView.addSubview(separator)
        contentView.addSubview(currencyName)
        configureLabels()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setCell(data: CurrencyRate) {
        currencyCode.text = data.currency.rawValue
        currencyName.text = data.locale
    }

    private func configureLabels() {
        currencyCode.font = R.font.sfProDisplayRegular(size: 17)
        currencyCode.textColor = R.color.mainView.textColor()

        currencyName.font = R.font.sfProDisplayRegular(size: 17)
        currencyName.numberOfLines = 0
        currencyName.textColor = R.color.mainView.textColor()

        setLabelsConstraints()
    }

    private func setLabelsConstraints() {
        currencyCode.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(20)
            make.centerY.equalToSuperview()
            make.width.equalTo(45)
        }
        separator.snp.makeConstraints { make in
            make.left.equalTo(currencyCode.snp.right)
            make.centerY.equalToSuperview()
            make.width.equalTo(30)
        }
        currencyName.snp.makeConstraints { make in
            make.left.equalTo(separator.snp.right)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview()
        }
    }
}
