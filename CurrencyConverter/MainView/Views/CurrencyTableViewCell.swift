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
    private var horizontalStack = UIStackView()
    private var currencyLabelHorizontalStack = UIStackView()
    private var viewController = MainViewController()

    private var chevronRightImageString: UILabel = {
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: "chevron.right")
        let text = UILabel()
        text.attributedText = NSAttributedString(attachment: imageAttachment)
        return text
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        textFieldView.fieldSettings = .onlyNumbers

        contentView.addSubview(horizontalStack)
        contentView.backgroundColor = R.color.converterView.backgroundColor()
        backgroundColor = R.color.converterView.backgroundColor()

        configureHorizontalStack()
        configureCurrencyLabelHorizontalStack()
        configureCurrencyLabel()

        textFieldView.delegate = viewController
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(currency: CurrencyRate) {
        currencyLabel.text = currency.currency.rawValue
        textFieldView.txtField.text = currency.rateString
    }

    func getCurrentRate() -> Double? {
        if let rate = Double(textFieldView.txtField.text!) {
            return rate
        }
        return nil
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
        currencyLabelHorizontalStack.addArrangedSubview(chevronRightImageString)

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
