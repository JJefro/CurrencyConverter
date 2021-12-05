//
//  MainViewController + Configuration.swift
//  CurrencyConverter
//
//  Created by Jevgenijs Jefrosinins on 30/11/2021.
//

import UIKit
import SnapKit

extension MainViewController {

    func configure() {
        title = R.string.localizable.mainView_navBar_title()
        setConverterViewConstraints()
        configureUpdateLabels()
        setExchangeRateButtonConstraints()
        addTargetsToButtons()
    }

    // MARK: - Buttons Targets
    private func addTargetsToButtons() {
        converterView.addCurrencyButton.addTarget(self, action: #selector(addCurrencyButtonPressed(_:)), for: .touchUpInside)
        converterView.segmentedControl.addTarget(self, action: #selector(segmentDidChange(_:)), for: .valueChanged)
        converterView.shareButton.addTarget(self, action: #selector(shareButtonPressed(_:)), for: .touchUpInside)
        
        updatingExchangeRateButton.addTarget(self, action: #selector(updatingExchangeRateButtonPressed(_:)), for: .touchUpInside)
    }

    // MARK: - ConverterView Constraints
    private func setConverterViewConstraints() {
        view.addSubview(converterView)
        converterView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(view.frame.size.height / 2)
            make.left.right.equalToSuperview().inset(16)
        }
    }

    // MARK: - UpdateLabels Configurations
    private func configureUpdateLabels() {
        updateLabel.text = R.string.localizable.mainView_lastUpdated_label()
        updateLabel.font = R.font.sfProDisplayRegular(size: 12)
        updateLabel.textColor = R.color.mainView.textColor()

        dateOfLastUpdateLabel.text = brain.getCurrentDataString()
        dateOfLastUpdateLabel.font = R.font.sfProDisplayRegular(size: 12)
        dateOfLastUpdateLabel.textColor = R.color.mainView.textColor()

        setUpdateLabelsConstraints()
    }

    private func setUpdateLabelsConstraints() {
        view.addSubview(updateLabel)
        updateLabel.snp.makeConstraints { make in
            make.top.equalTo(converterView.snp.bottom).offset(10)
            make.left.equalToSuperview().inset(20)
        }
        view.addSubview(dateOfLastUpdateLabel)
        dateOfLastUpdateLabel.snp.makeConstraints { make in
            make.top.equalTo(updateLabel.snp.bottom).offset(5)
            make.left.equalToSuperview().inset(20)
        }
    }

    // MARK: - ExchangeRateButton Constraints
    private func setExchangeRateButtonConstraints() {
        view.addSubview(updatingExchangeRateButton)
        updatingExchangeRateButton.snp.makeConstraints { make in
            make.top.greaterThanOrEqualTo(dateOfLastUpdateLabel.snp.bottom).offset(20)
            make.bottom.equalToSuperview().inset(160).priority(250)
            make.height.equalTo(56)
            make.left.right.equalToSuperview().inset(40)
        }
    }
}
