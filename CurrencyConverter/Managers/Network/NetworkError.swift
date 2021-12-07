//
//  NetworkError.swift
//  CurrencyConverter
//
//  Created by Jevgenijs Jefrosinins on 07/12/2021.
//

import Foundation

enum NetworkError: Error {
    case badStatusCode
    case badURL
    case badServerResponse
    case noDataError
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .badStatusCode:
            return R.string.localizable.networkError_badStatusCode()
        case .badURL:
            return R.string.localizable.networkError_badURL()
        case .badServerResponse:
            return R.string.localizable.networkError_badServerResponse()
        case .noDataError:
            return R.string.localizable.networkError_noDataError()
        }
    }
}
