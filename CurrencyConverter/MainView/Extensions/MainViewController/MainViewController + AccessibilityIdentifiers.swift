//
//  MainViewController + CreatingAccessibilityIdentifiers.swift
//  CurrencyConverter
//
//  Created by Jevgenijs Jefrosinins on 21/01/2022.
//

import Foundation

extension MainViewController {

    func setAccessibilityIdentifiers() {
        view.accessibilityIdentifier = MainViewAccessibilityID.mainView
        navigationController?.navigationBar.accessibilityIdentifier = MainViewAccessibilityID.navigationBar
        navigationController?.navigationBar.topItem?.backBarButtonItem?.accessibilityIdentifier = MainViewAccessibilityID.backButton

        converterView.accessibilityIdentifier = MainViewAccessibilityID.converterView
        converterView.segmentedControl.accessibilityIdentifier = MainViewAccessibilityID.segmentedControl
        converterView.tableView.accessibilityIdentifier = MainViewAccessibilityID.tableView

        converterView.shareButton.accessibilityIdentifier = MainViewAccessibilityID.shareButton
        converterView.addCurrencyButton.accessibilityIdentifier = MainViewAccessibilityID.addCurrencyButton
        updatingExchangeRateButton.accessibilityIdentifier = MainViewAccessibilityID.exchangeRateButton

        updateLabel.accessibilityIdentifier = MainViewAccessibilityID.updateLabel
        dateOfLastUpdateLabel.accessibilityIdentifier = MainViewAccessibilityID.dateOfLastUpdateLabel
    }
}
