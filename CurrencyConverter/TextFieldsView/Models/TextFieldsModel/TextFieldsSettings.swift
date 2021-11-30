//
//  TextFieldsModel.swift
//  textFields!
//
//  Created by Jevgenijs Jefrosinins on 22/09/2021.
//

import Foundation
import UIKit

enum TextFieldsSettings {
    case onlyLetters
    case inputLimit
    case onlyCharacters
    case link
    case validationRules

    var title: String {
        switch self {
        case .onlyLetters:
            return R.string.localizable.textFields_title_onlyLetters()
        case .inputLimit:
            return R.string.localizable.textFields_title_inputLimit()
        case .onlyCharacters:
            return R.string.localizable.textFields_title_onlyCharacters()
        case .link:
            return R.string.localizable.textFields_title_link()
        case .validationRules:
            return R.string.localizable.textFields_title_validationRules()
        }
    }
    
    var placeholder: String {
        switch self {
        case .onlyLetters:
            return R.string.localizable.textFields_placeholder_onlyLetters()
        case .inputLimit:
            return R.string.localizable.textFields_placeholder_inputLimit()
        case .onlyCharacters:
            return R.string.localizable.textFields_placeholder_onlyCharacters()
        case .link:
            return R.string.localizable.textFields_placeholder_link()
        case .validationRules:
            return R.string.localizable.textFields_placeholder_validationRules()
        }
    }
}
