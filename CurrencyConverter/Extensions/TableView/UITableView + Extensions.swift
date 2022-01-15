//
//  UITableView + Extensions.swift
//  CurrencyConverter
//
//  Created by Jevgenijs Jefrosinins on 15/01/2022.
//

import Foundation
import UIKit

extension UITableView {
    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withIdentifier: T.reuseIdentifier, for: indexPath) as? T else {
            fatalError("Unable to dequeue reusable Table View Cell")
        }
        return cell
    }
}
