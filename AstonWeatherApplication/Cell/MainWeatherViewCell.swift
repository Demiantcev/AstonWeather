//
//  MainWeatherViewCell.swift
//  AstonWeatherApplication
//
//  Created by Кирилл Демьянцев on 19.07.2023.
//

import UIKit
import SnapKit

final class MainWeatherViewCell: UITableViewCell {
    
    private enum FontLabel {
        static let labelFont: CGFloat = 18
        static let conditionFont: CGFloat = 12
    }
    
    private let firstMargin: CGFloat = 10
    private let secondMargin: CGFloat = 30
    
    static let reuseId = "MainWeatherViewCell"
    
    weak var viewModel: MainWeatherCellViewModel! {
        didSet {
            self.conditionLabel.text = viewModel.conditionString
            self.nameCityLabel.text = viewModel.cityTitle
            self.temperatureLabel.text = viewModel.temperatureString
        }
    }
    
    let nameCityLabel: UILabel = {
        var label = UILabel()
        label.font = .boldSystemFont(ofSize: FontLabel.labelFont)
        label.textColor = .black
        return label
    }()
    
    let conditionLabel: UILabel = {
        var label = UILabel()
        label.font = .boldSystemFont(ofSize: FontLabel.conditionFont)
        label.textColor = .darkGray
        return label
    }()
    
    let temperatureLabel: UILabel = {
        var label = UILabel()
        label.font = .boldSystemFont(ofSize: FontLabel.labelFont)
        label.textColor = .black
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupConstraints()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func setupConstraints() {
        
        [nameCityLabel, conditionLabel, temperatureLabel].forEach {
            addSubview($0)
        }
        
        nameCityLabel.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview().inset(firstMargin)
        }
        temperatureLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(firstMargin)
            make.trailing.equalToSuperview().inset(secondMargin)
        }
        conditionLabel.snp.makeConstraints { make in
            make.trailing.equalTo(temperatureLabel.snp.leading).offset(-firstMargin)
            make.top.bottom.equalToSuperview().inset(firstMargin)
        }
    }
}
