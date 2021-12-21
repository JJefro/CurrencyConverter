//
//  ConverterBrain.swift
//  CurrencyConverter
//
//  Created by Jevgenijs Jefrosinins on 21/12/2021.
//

import Foundation

protocol ConverterBrainDelegate: AnyObject {
    func update(rates: [CurrencyRate])
}

class ConverterBrain {

    weak var delegate: ConverterBrainDelegate?
    
}
