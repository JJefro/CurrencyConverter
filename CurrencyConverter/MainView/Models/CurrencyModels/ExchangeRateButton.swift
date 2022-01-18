//
//  ExchangeRateButtonView.swift
//  CurrencyConverter
//
//  Created by Jevgenijs Jefrosinins on 04/12/2021.
//

import Foundation
import UIKit

class ExchangeRateButton: CardButton {

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }

    private func configure() {
        var config = UIButton.Configuration.plain()

        var attrTitle = AttributedString(R.string.localizable.mainView_updatingExchangeRateButton_title())
        attrTitle.font = R.font.sfProDisplayBold(size: 17)
        attrTitle.foregroundColor = R.color.mainView.buttonsColor()
        config.attributedTitle = attrTitle

        self.configuration = config
        self.layer.cornerRadius = 14
        self.layer.borderWidth = 1
        self.layer.borderColor = R.color.mainView.buttonsColor()?.cgColor
    }
}
