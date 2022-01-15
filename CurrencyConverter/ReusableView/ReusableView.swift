//
//  ReusableView.swift
//  CurrencyConverter
//
//  Created by Jevgenijs Jefrosinins on 15/01/2022.
//

import Foundation

protocol ReusableView {
    static var reuseIdentifier: String { get }
}

extension ReusableView {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}
