//
//  CardButton.swift
//  CurrencyConverter
//
//  Created by Jevgenijs Jefrosinins on 05/12/2021.
//

import UIKit

class CardButton: UIButton {

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.5, delay: 0, options: .allowUserInteraction, animations: {
            self.transform = CGAffineTransform(scaleX: 0.85, y: 0.85)
        }, completion: nil)
        super.touchesBegan(touches, with: event)
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIView.animate(withDuration: 0.5, delay: 0, options: .allowUserInteraction, animations: {
            self.transform = .identity
        }, completion: nil)
        super.touchesEnded(touches, with: event)
    }
}
