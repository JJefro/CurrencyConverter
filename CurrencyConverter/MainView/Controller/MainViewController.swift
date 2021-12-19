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

    let repository = DataManager(localDataSource: RatesLocalDataSource(), remoteDataSource: RatesRemoteDataSource(networkManager: NetworkManager()))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    @objc func segmentDidChange(_ sender: UISegmentedControl) {
    }

    @objc func addCurrencyButtonPressed(_ sender: UIButton) {
    }

    @objc func shareButtonPressed(_ sender: UIButton) {

    }

    @objc func updatingExchangeRateButtonPressed(_ sender: UIButton) {
        repository.fetchRates { result in
            switch result {
            case let .success(rates):
                self.converterView.dataSource.objects = rates.wrappedValue
                self.converterView.tableView.reloadData()
            case let .failure(error):
                print(error)
            }
        }
    }
}

extension MainViewController: CurrencyTableViewDataSourceDelegate {
    func getBaseCurrency(currency: Currency) {
    }
}
