//
//  Secrets.swift
//  CurrencyConverter
//
//  Created by Jevgenijs Jefrosinins on 07/12/2021.
//

import UIKit

struct Secrets {

    static var apiKey: String {
        get {
            guard let filePath = Bundle.main.path(forResource: "Secrets", ofType: "plist") else {
                fatalError("Couldn't find file 'Secrets.plist'.")
            }
            let plist = NSDictionary(contentsOfFile: filePath)
            guard let value = plist?.object(forKey: "Currency Rates API key") as? String else {
                fatalError("Couldn't find key 'Currency Rates API key' in 'Secrets.plist'.")
            }
            if value == "YOUR_API_KEY" {
                fatalError("Write your API key into Secrets.plist file.")
            }
            return value
        }
    }
}
