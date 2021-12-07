//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Jevgenijs Jefrosinins on 26/11/2021.
//

import UIKit

class MainViewController: UIViewController {

    var converterView = ConverterView()
    var updateLabel = UILabel()
    var dateOfLastUpdateLabel = UILabel()
    var updatingExchangeRateButton = ExchangeRateButton()

    var brain = Brain()

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    @objc func segmentDidChange(_ sender: UISegmentedControl) {
    }

    @objc func addCurrencyButtonPressed(_ sender: UIButton) {
        print("Add Currency Button Pressed")
    }

    @objc func shareButtonPressed(_ sender: UIButton) {
    }

    @objc func updatingExchangeRateButtonPressed(_ sender: UIButton) {
        brain.convertCurrencies(currency: .EUR, toCurrency: .USD) {
            print("success")
        }
        print("Exchange Rate Button Pressed")
    }
}
