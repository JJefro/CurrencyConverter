//
//  ExchangeRateButtonView.swift
//  CurrencyConverter
//
//  Created by Jevgenijs Jefrosinins on 04/12/2021.
//

import Foundation
import UIKit

class ExchangeRateButton: CardButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        var config = UIButton.Configuration.plain()

        var attrTitle = AttributedString(R.string.localizable.mainView_updatingExchangeRateButton_title())
        attrTitle.font = R.font.sfProDisplayBold(size: 17)
        attrTitle.foregroundColor = R.color.mainView.blue()
        config.attributedTitle = attrTitle

        self.configuration = config
        self.layer.cornerRadius = 14
        self.layer.borderWidth = 1
        self.layer.borderColor = R.color.mainView.blue()?.cgColor
    }
}
