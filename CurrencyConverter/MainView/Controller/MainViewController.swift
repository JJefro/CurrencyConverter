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
    var fetchedRates: [CurrencyRate] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        updateData()
        setAccessibilityIdentifiers()
    }

    @objc func segmentDidChange(_ sender: UISegmentedControl) {
    }

    @objc func addCurrencyButtonPressed(_ sender: UIButton) {
        let currenciesListVC = CurrenciesListViewController()
        currenciesListVC.currencies = fetchedRates
        currenciesListVC.delegate = self
        navigationController?.pushViewController(currenciesListVC, animated: true)
    }

    @objc func shareButtonPressed(_ sender: UIButton) {
        UIGraphicsBeginImageContextWithOptions(UIScreen.main.bounds.size, true, 0.0)
        self.view.drawHierarchy(in: UIScreen.main.bounds, afterScreenUpdates: false)
        let imageToShare = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        let activityController = UIActivityViewController(activityItems: [imageToShare!], applicationActivities: nil)

        activityController.popoverPresentationController?.sourceView = sender
        self.present(activityController, animated: true, completion: nil)
    }

    @objc func exchangeRateButtonPressed(_ sender: UIButton) {
        updateData()
    }

    private func updateData() {
        brain.updateCurrencyRates()
    }

    private func showErrorAlert(title: String?, message: String?) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .destructive, handler: { [self] _ in updateData() }))
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: - TableViewDataSource Delegate Methods
extension MainViewController: TableViewDataSourceDelegate {
    func tableViewDataSource(_ tableViewDataSource: TableViewDataSource, didRemoveCurrency currency: Currency) {
        brain.deleteCurrency(currency)
    }

    func tableViewDataSource(_ tableViewDataSource: TableViewDataSource, didChangeCurrencyValue text: String, for currency: Currency) {
        brain.calculateRates(value: text, currency: currency)
    }
}

// MARK: - ConverterBrain Delegate Methods
extension MainViewController: ConverterBrainDelegate {
    func converterBrain(_ converterBrain: ConverterBrainProtocol, didFetchCurrencies rates: [CurrencyRate]) {
        fetchedRates = rates
    }

    func converterBrain(_ converterBrain: ConverterBrainProtocol, didConvertRates rates: [CurrencyExchangeData]) {
        converterView.objects = rates
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

// MARK: - CurrenciesListViewController Delegate Methods
extension MainViewController: CurrenciesListViewControllerDelegate {
    func currenciesListViewController(_ currencyListViewController: CurrenciesListViewController, didSelectCurrency currency: Currency) {
        brain.saveCurrency(currency)
        converterView.reloadTableView()
    }
}
