//
//  MainViewController + Configuration.swift
//  CurrencyConverter
//
//  Created by Jevgenijs Jefrosinins on 30/11/2021.
//

import UIKit
import SnapKit

extension MainViewController {

    func configure() {
        title = R.string.localizable.mainView_navBar_title()
    }

    private func configureContentView() {
        view.addSubview(contentView)
        setContentViewConstraints()
    }

    private func setContentViewConstraints() {
        contentView.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(40)
            make.height.equalTo(400)
        }
    }
}
