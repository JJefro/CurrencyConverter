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
        view.backgroundColor = R.color.mainView.backgroundColor()
        configureUpdateLabels()
        addTargetsToButtons()
        setLoadingViewConstraints()
        converterView.configureTableView()
        bind()
    }

    func bind() {
        converterView.dataSource.delegate = self
//        converterView.cell.textFieldView.delegate = self // Doesn't work
        brain.delegate = self
    }

    // MARK: - Buttons Targets
    private func addTargetsToButtons() {
        converterView.addCurrencyButton.addTarget(self, action: #selector(addCurrencyButtonPressed(_:)), for: .touchUpInside)
        converterView.segmentedControl.addTarget(self, action: #selector(segmentDidChange(_:)), for: .valueChanged)
        converterView.shareButton.addTarget(self, action: #selector(shareButtonPressed(_:)), for: .touchUpInside)
        
        updatingExchangeRateButton.addTarget(self, action: #selector(exchangeRateButtonPressed(_:)), for: .touchUpInside)
    }

    private func setLoadingViewConstraints() {
        view.addSubview(loadingView)
        loadingView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }

    // MARK: - UpdateLabels Configurations
    private func configureUpdateLabels() {
        updateLabel.text = R.string.localizable.mainView_lastUpdated_label()
        updateLabel.font = R.font.sfProDisplayRegular(size: 12)
        updateLabel.textColor = R.color.mainView.textColor()

        dateOfLastUpdateLabel.font = R.font.sfProDisplayRegular(size: 12)
        dateOfLastUpdateLabel.textColor = R.color.mainView.textColor()
    }
}
