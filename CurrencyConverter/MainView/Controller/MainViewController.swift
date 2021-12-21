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

    var baseCurrency: Currency = .init(rawValue: "EUR")
    var currentCurrencies: [Currency] = [Currency(rawValue: "USD"), Currency(rawValue: "EUR"), Currency(rawValue: "RUB"), Currency(rawValue: "CNY")]

    var brain = ConverterBrain()
    var loadingView = LoadingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        updateData()
    }

    @objc func segmentDidChange(_ sender: UISegmentedControl) {
    }

    @objc func addCurrencyButtonPressed(_ sender: UIButton) {
    }

    @objc func shareButtonPressed(_ sender: UIButton) {

    }

    @objc func updatingExchangeRateButtonPressed(_ sender: UIButton) {
        updateData()
    }

    private func updateData() {
        loadingView.isHidden = false
        repository.fetchRates(currencies: currentCurrencies) { [self] result in
            switch result {
            case let .success(rates):
                dateOfLastUpdateLabel.text = rates.createdAt.formatted(date: .abbreviated, time: .shortened)
                updateDataSourceObjects(rates)
            case let .failure(error):
                showErrorAlert(title: nil, message: error.localizedDescription)
            }
            loadingView.isHidden = true
        }
    }

    private func updateDataSourceObjects(_ rates: Timestamped<[CurrencyRate]>) {
        let filteredRates = rates.wrappedValue.filter { $0.base == self.baseCurrency }
        converterView.dataSource.objects = filteredRates.filter {self.currentCurrencies.contains($0.currency)}
        converterView.tableView.reloadData()
    }

    private func showErrorAlert(title: String?, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
}

extension MainViewController: ConverterBrainDelegate {
    func update(rates: [CurrencyRate]) {
        converterView.dataSource.objects = rates

    }
}

extension MainViewController: CurrencyTableViewDataSourceDelegate {
    func getBaseCurrency(currency: Currency) {
        baseCurrency = currency
        updateData()
    }
}
