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

    private var imageAttachment: NSAttributedString = {
        let imageAttachment = NSTextAttachment()
        imageAttachment.image = UIImage(systemName: "chevron.right")
        imageAttachment.bounds = CGRect(x: 0, y: -2, width: imageAttachment.image!.size.width, height: imageAttachment.image!.size.height)
        return NSAttributedString(attachment: imageAttachment)
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        textFieldView.fieldSettings = .onlyNumbers

        contentView.addSubview(horizontalStack)
        contentView.backgroundColor = R.color.converterView.backgroundColor()
        backgroundColor = R.color.converterView.backgroundColor()

        configureHorizontalStack()
        configureCurrencyLabel()
        setTextFieldConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(currency: CurrencyRate) {
        let currencyString = currency.currency.rawValue
        let text = NSMutableAttributedString(string: currencyString)
        let spacing = NSMutableAttributedString(string: "  ")
        text.append(spacing)
        text.append(imageAttachment)
        currencyLabel.attributedText = text
        textFieldView.txtField.text = String(currency.rateString)
    }

    // MARK: - HorizontalStack Configurations
    private func configureHorizontalStack() {
        horizontalStack.axis = .horizontal
        horizontalStack.distribution = .fill
        horizontalStack.spacing = 7
        horizontalStack.alignment = .center
        horizontalStack.addArrangedSubview(currencyLabel)
        horizontalStack.addArrangedSubview(textFieldView)

        setHorizontalStackConstraints()
    }

    private func setHorizontalStackConstraints() {
        horizontalStack.snp.makeConstraints { make in
            switch UIDevice.current.userInterfaceIdiom {
            case .pad, .mac:
                make.width.equalToSuperview().dividedBy(2.3)
            default:
                make.width.equalToSuperview().dividedBy(1.3)
            }
            make.height.equalToSuperview()
            make.center.equalToSuperview()
        }
    }

    // MARK: - CurrencyLabel Configurations
    private func configureCurrencyLabel() {
        currencyLabel.font = R.font.sfProDisplayRegular(size: 17)
        currencyLabel.textAlignment = .center
        currencyLabel.textColor = R.color.mainView.textColor()
    }

    // MARK: - TextFieldView Constraints
    private func setTextFieldConstraints() {
        textFieldView.snp.makeConstraints { make in
            make.width.lessThanOrEqualTo(200)
        }
    }
}
