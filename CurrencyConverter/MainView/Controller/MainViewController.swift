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

    @objc func updatingExchangeRateButtonPressed(_ sender: UIButton) {
        updateData()
    }

    private func updateData() {
        loadingView.isHidden = false
        brain.updateData { [self] result in
            switch result {
            case let .success((date, rates)):
                dateOfLastUpdateLabel.text = date
                converterView.dataSource.objects = rates
                converterView.tableView.reloadData()
            case let .failure(error):
                showErrorAlert(title: nil, message: error.localizedDescription)
            }
            loadingView.isHidden = true
        }
    }

    private func showErrorAlert(title: String?, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .destructive, handler: { [self] _ in updateData() }))
        present(alertController, animated: true, completion: nil)
    }
}

extension MainViewController: CurrencyTableViewDataSourceDelegate {
    func getBaseCurrency(currency: Currency) {
        brain.baseCurrency = currency
        updateData()
    }
}
