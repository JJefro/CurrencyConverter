//
//  ViewController.swift
//  CurrencyConverter
//
//  Created by Jevgenijs Jefrosinins on 26/11/2021.
//

import UIKit

class MainViewController: UIViewController {

    @IBOutlet weak var converterView: ConverterView!
    @IBOutlet weak var updateLabel: UILabel!
    @IBOutlet weak var dateOfLastUpdateLabel: UILabel!
    @IBOutlet weak var updatingExchangeRateButton: ExchangeRateButton!

    var brain = CurrencyBrain()

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
        brain.convert(completion: { currencyEntity in
            self.converterView.dataSource.objects = currencyEntity.data
            self.converterView.tableView.reloadData()
        })
    }
}
