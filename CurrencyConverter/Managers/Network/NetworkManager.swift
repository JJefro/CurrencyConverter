//
//  NetworkManager.swift
//  CurrencyConverter
//
//  Created by Jevgenijs Jefrosinins on 07/12/2021.
//

import Foundation

typealias RequestCompletion = (Result<CurrencyData, Error>) -> Void
typealias CurrencyRatesCompletion = ((_ currencyRates: Result<CurrencyData, Error>) -> Void)

class NetworkManager {

    private var currencyURL = "https://freecurrencyapi.net/api/v2/latest?apikey=\(Secrets.apiKey)"
    private var networkRequestCompletion: (RequestCompletion)?

    func getCurrencyRatesFrom(baseCurrency: Currency, completion: @escaping CurrencyRatesCompletion) {
        let url = "\(currencyURL)&base_currency=\(String(describing: baseCurrency))"
        performRequest(url: url) { result in
            completion(result)
        }
    }

    func getHistoricalCurrencyRates(fromDate: String, toDate: String, baseCurrency: Currency, completion: @escaping CurrencyRatesCompletion) {
        let url = "\(currencyURL)&base_currency=\(String(describing: baseCurrency))&date_from=\(fromDate)&date_to=\(toDate)"
        performRequest(url: url) { result in
            completion(result)
        }
    }

    private func performRequest(url: String, completion: @escaping RequestCompletion) {
        guard let url = URL(string: url) else {
            DispatchQueue.main.async {
                completion(.failure(NetworkError.badURL))
            }
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        let config = URLSessionConfiguration.default
        config.waitsForConnectivity = true

        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request) { currencyData, response, error in
            guard let response = response as? HTTPURLResponse else {
                DispatchQueue.main.async {
                    completion(.failure(NetworkError.badServerResponse))
                }
                return
            }
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(error))
                }
                return
            } else {
                if let safeData = currencyData {
                    if response.statusCode / 100 == 2 {
                        if let data = self.parseJSON(safeData) {
                            DispatchQueue.main.async {
                                completion(.success(data))
                            }
                        }
                    } else {
                        DispatchQueue.main.async {
                            completion(.failure(NetworkError.badStatusCode))
                        }
                        return
                    }
                }
            }
        }
        task.resume()
    }

    private func parseJSON(_ currencyData: Data) -> CurrencyData? {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        do {
            let decoderData = try decoder.decode(CurrencyData.self, from: currencyData)
            return decoderData
        } catch {
            networkRequestCompletion?(.failure(error))
            return nil
        }
    }
}
