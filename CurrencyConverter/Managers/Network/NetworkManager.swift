//
//  NetworkManager.swift
//  CurrencyConverter
//
//  Created by Jevgenijs Jefrosinins on 07/12/2021.
//

import Foundation

typealias RequestCompletion = (Result<CurrencyEntity, Error>) -> Void
typealias CurrencyRatesCompletion = ((_ currencyRates: Result<CurrencyEntity, Error>) -> Void)

protocol NetworkManagerProtocol {
    func getRatesFrom(_ baseCurrency: Currency, completion: @escaping CurrencyRatesCompletion)
    func getHistoricalCurrencyRates(fromDate: String, toDate: String, baseCurrency: Currency, completion: @escaping CurrencyRatesCompletion)
    func performRequest(url: URL?, completion: @escaping RequestCompletion)
}

class NetworkManager: NetworkManagerProtocol {

    private var components: URLComponents = {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "freecurrencyapi.net"
        urlComponents.path = "/api/v2/latest"
        urlComponents.queryItems = [URLQueryItem(name: "apikey", value: Secrets.apiKey)]
        return urlComponents
    }()

    private var networkRequestCompletion: (RequestCompletion)?

    func getRatesFrom(_ baseCurrency: Currency, completion: @escaping CurrencyRatesCompletion) {
        var urlComponents = components
        let baseCurrencyItemQuery = URLQueryItem(name: "base_currency", value: baseCurrency.rawValue)
        urlComponents.queryItems?.append(baseCurrencyItemQuery)
        performRequest(url: urlComponents.url) { result in
            completion(result)
        }
    }

    func getHistoricalCurrencyRates(fromDate: String, toDate: String, baseCurrency: Currency, completion: @escaping CurrencyRatesCompletion) {
        var urlComponents = components
        let baseCurrencyItemQuery = URLQueryItem(name: "base_currency", value: baseCurrency.rawValue)
        let dateFromItemQuery = URLQueryItem(name: "date_from", value: fromDate)
        let toDateItemQuery = URLQueryItem(name: "date_to", value: toDate)
        urlComponents.queryItems?.append(contentsOf: [baseCurrencyItemQuery, dateFromItemQuery, toDateItemQuery])
        performRequest(url: urlComponents.url) { result in
            completion(result)
        }
    }

    func performRequest(url: URL?, completion: @escaping RequestCompletion) {
        guard let url = url else {
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

    private func parseJSON(_ currencyData: Data) -> CurrencyEntity? {
        let decoder = JSONDecoder()
        do {
            let decoderData = try decoder.decode(CurrencyData.self, from: currencyData)
            return CurrencyEntity(decoderData)
        } catch {
            networkRequestCompletion?(.failure(error))
            return nil
        }
    }
}
