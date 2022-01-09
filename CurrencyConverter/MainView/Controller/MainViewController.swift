//
//  MainViewController.swift
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

    var brain: ConverterBrainProtocol = ConverterBrain(repository: DataManager(
                                                            localDataSource: RatesLocalDataSource(),
                                                            remoteDataSource: RatesRemoteDataSource(networkManager: NetworkManager())))
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

    @objc func exchangeRateButtonPressed(_ sender: UIButton) {
        updateData()
    }

    private func updateData() {
        brain.updateData()
    }

    private func showErrorAlert(title: String?, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .destructive, handler: { [self] _ in updateData() }))
        present(alertController, animated: true, completion: nil)
    }
}

extension MainViewController: TableViewDataSourceDelegate {

    func tableViewDataSource(_ tableViewDataSource: TableViewDataSource, textFieldEditingChanged text: String) {
        brain.baseRate = Double(text) ?? 1
    }

    func tableViewDataSource(_ currencyTableViewDataSource: TableViewDataSource, didChangeBaseCurrency currency: Currency) {
        brain.baseCurrency = currency
    }
}

extension MainViewController: ConverterBrainDelegate {
    
    func converterBrain(_ converterBrain: ConverterBrainProtocol, didUpdateRates rates: [CurrencyRate]) {
        converterView.dataSource.objects = rates
        converterView.tableView.reloadData()
    }

    func converterBrain(_ converterBrain: ConverterBrainProtocol, didUpdateDate date: Date) {
        dateOfLastUpdateLabel.text = date.formatted(date: .abbreviated, time: .shortened)
    }

    func converterBrain(_ converterBrain: ConverterBrainProtocol, errorOccured error: Error) {
        showErrorAlert(title: nil, message: error.localizedDescription)
    }

    func converterBrain(_ converterBrain: ConverterBrainProtocol, didUpdateLoading isLoading: Bool) {
        loadingView.isHidden = !isLoading
    }
}
