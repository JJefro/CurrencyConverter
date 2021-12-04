//
//  ConverterView.swift
//  CurrencyConverter
//
//  Created by Jevgenijs Jefrosinins on 03/12/2021.
//

import UIKit
import SnapKit

class ConverterView: UIView {

    var segmentedControl = UISegmentedControl()
    var tableView = UITableView()
    var addCurrencyButton = UIButton()
    var shareButton = UIButton()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.masksToBounds = false
        layer.cornerRadius = 10
        layer.shadowRadius = 1
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowColor = R.color.converterView.shadowColor()?.cgColor

        configure()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        configureSegmentedControl()
        configureAddCurrencyButton()
        configureTableView()
        configureShareButton()
    }

    // MARK: - SegmentedControl Configurations
    private func configureSegmentedControl() {
        let firstSegmentTitle = R.string.localizable.mainView_segmentTitle_sell()
        let secondSegmentTitle = R.string.localizable.mainView_segmentTitle_buy()

        segmentedControl.insertSegment(withTitle: firstSegmentTitle, at: 0, animated: true)
        segmentedControl.insertSegment(withTitle: secondSegmentTitle, at: 1, animated: true)

        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.white], for: .selected)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .normal)

        segmentedControl.selectedSegmentTintColor = R.color.mainView.blue()
        segmentedControl.selectedSegmentIndex = 0
        setSegmentedControlConstraints()
    }

    private func setSegmentedControlConstraints() {
        self.addSubview(segmentedControl)
        segmentedControl.snp.makeConstraints { make in
            make.leading.trailing.top.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
    }

    // MARK: - UITableView Configurations
    private func configureTableView() {
        setTableViewConstraints()
    }

    private func setTableViewConstraints() {
        self.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(segmentedControl.snp.bottom)
            make.leading.trailing.equalToSuperview().inset(20)
            make.bottom.equalTo(addCurrencyButton.snp.top)
        }
    }

    // MARK: AddCurrencyButton Configurations
    private func configureAddCurrencyButton() {
        var config = UIButton.Configuration.plain()

        var attrTitle = AttributedString(R.string.localizable.mainView_addCurrencyButton_title())
        attrTitle.font = R.font.sfProDisplayRegular(size: 14)
        attrTitle.foregroundColor = R.color.mainView.blue()

        config.image = UIImage(systemName: "plus.circle.fill")
        config.baseForegroundColor = R.color.mainView.blue()
        config.imagePadding = 5
        config.imagePlacement = .leading
        config.attributedTitle = attrTitle

        addCurrencyButton.configuration = config
        setAddCurrencyButtonConstraints()
    }

    private func setAddCurrencyButtonConstraints() {
        self.addSubview(addCurrencyButton)
        addCurrencyButton.snp.makeConstraints { make in
            make.bottom.equalTo(self.snp.bottom).inset(30)
            make.centerX.equalToSuperview()
        }
    }

    // MARK: - ShareButtonConfiguretion
    private func configureShareButton() {
        let imageLargeConfig = UIImage.SymbolConfiguration.init(scale: .large)
        var config = UIButton.Configuration.plain()
        config.image = UIImage(systemName: "square.and.arrow.up", withConfiguration: imageLargeConfig)
        config.baseForegroundColor = R.color.mainView.blue()

        shareButton.configuration = config
        setShareButtonConstraints()
    }

    private func setShareButtonConstraints() {
        self.addSubview(shareButton)
        shareButton.snp.makeConstraints { make in
            make.right.bottom.equalToSuperview().inset(10)
        }
    }
}
