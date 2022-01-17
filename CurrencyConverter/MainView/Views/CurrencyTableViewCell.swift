//
//  CurrencyTableViewCell.swift
//  CurrencyConverter
//
//  Created by Jevgenijs Jefrosinins on 05/12/2021.
//

import UIKit
import SnapKit

protocol CurrencyTableViewCellDelegate: AnyObject {
    func currencyTableViewCell(_ currencyTableViewCell: CurrencyTableViewCell, currencyValueDidChange text: String, for currency: Currency)
}

class CurrencyTableViewCell: UITableViewCell {

    weak var delegate: CurrencyTableViewCellDelegate?
    override var isFirstResponder: Bool { textFieldView.txtField.isFirstResponder }

    private var currencyLabel = UILabel()
    private var horizontalStack = UIStackView()
    private var currencyLabelHorizontalStack = UIStackView()
    private var textFieldView = TextFieldView()
    private var currency: Currency!

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        textFieldView.fieldSettings = .onlyNumbers

        contentView.addSubview(horizontalStack)
        contentView.backgroundColor = R.color.converterView.backgroundColor()
        backgroundColor = R.color.converterView.backgroundColor()
        selectionStyle = .none

        configureHorizontalStack()
        configureCurrencyLabelHorizontalStack()
        configureCurrencyLabel()

        textFieldView.txtField.addTarget(self, action: #selector(textFieldEditingChanged(_:)), for: .editingChanged)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private var chevronRightImage: UIImageView = {
        let font = R.font.sfProDisplayRegular(size: 17)
        let configuration = UIImage.SymbolConfiguration(font: font!)
        let image = UIImage(systemName: "chevron.right", withConfiguration: configuration)
        let imageView = UIImageView(image: image)
        imageView.tintColor = R.color.mainView.textColor()
        return imageView
    }()

    @objc private func textFieldEditingChanged(_ sender: UITextField) {
        if let text = sender.text {
            delegate?.currencyTableViewCell(self, currencyValueDidChange: text, for: currency)
        }
    }

    func updateCell(data: CurrencyExchangeData) {
        self.currency = data.currency
        currencyLabel.text = data.currency.rawValue
        if let exchangeValue = data.exchangeValueString {
            textFieldView.txtField.text = exchangeValue
        } else {
            textFieldView.txtField.text?.removeAll()
        }
    }

    // MARK: - HorizontalStack Configurations
    private func configureHorizontalStack() {
        horizontalStack.axis = .horizontal
        horizontalStack.distribution = .fillProportionally
        horizontalStack.spacing = 7
        horizontalStack.alignment = .center
        horizontalStack.addArrangedSubview(currencyLabelHorizontalStack)
        horizontalStack.addArrangedSubview(textFieldView)

        setHorizontalStackConstraints()
    }

    private func setHorizontalStackConstraints() {
        horizontalStack.snp.makeConstraints { make in
            switch UIDevice.current.userInterfaceIdiom {
            case .pad, .mac:
                make.width.equalToSuperview().dividedBy(2.8)
            default:
                make.width.equalToSuperview().dividedBy(1.4)
            }
            make.height.equalToSuperview()
            make.center.equalToSuperview()
        }
    }

    private func configureCurrencyLabelHorizontalStack() {
        currencyLabelHorizontalStack.axis = .horizontal
        currencyLabelHorizontalStack.distribution = .equalSpacing
        currencyLabelHorizontalStack.alignment = .center
        currencyLabelHorizontalStack.addArrangedSubview(currencyLabel)
        currencyLabelHorizontalStack.addArrangedSubview(chevronRightImage)

        setCurrencyLabelHorizontalStackConstraints()
    }

    private func setCurrencyLabelHorizontalStackConstraints() {
        currencyLabelHorizontalStack.snp.makeConstraints { make in
            make.width.equalTo(50)
        }
    }

    // MARK: - CurrencyLabel Configurations
    private func configureCurrencyLabel() {
        currencyLabel.font = R.font.sfProDisplayRegular(size: 17)
        currencyLabel.textAlignment = .left
        currencyLabel.textColor = R.color.mainView.textColor()
    }
}
