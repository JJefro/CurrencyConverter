//
//  CurrencyTableViewCell.swift
//  CurrencyConverter
//
//  Created by Jevgenijs Jefrosinins on 05/12/2021.
//

import UIKit
import SnapKit

class CurrencyTableViewCell: UITableViewCell {

    static let identifier = "CurrencyTableViewCell"

    private var currencyLabel = UILabel()
    private var textFieldView = TextFieldView()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        textFieldView.fieldSettings = .onlyNumbers

        contentView.addSubview(textFieldView)
        contentView.addSubview(currencyLabel)
        
        setTextFieldViewConstraints()
        configureCurrencyLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(currency: String) {
        currencyLabel.text = currency
    }

    // MARK: - CurrencyLabel Configurations
    private func configureCurrencyLabel() {
        currencyLabel.font = R.font.sfProDisplayRegular(size: 17)
        currencyLabel.textColor = R.color.mainView.textColor()

        setCurrencyLabelConstraints()
    }
    private func setCurrencyLabelConstraints() {
        currencyLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(40)
        }
    }

    // MARK: - TextFieldView Constraints
    private func setTextFieldViewConstraints() {
        textFieldView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().inset(20)
            make.width.equalTo(200)
            make.height.equalTo(30)
        }
    }
}
