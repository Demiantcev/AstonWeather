//
//  ForecastTableViewCell.swift
//  AstonWeatherApplication
//
//  Created by Кирилл Демьянцев on 21.07.2023.
//

import UIKit
import SnapKit
import SwiftSVG

final class ForecastTableViewCell: UITableViewCell {
    
    private var networkManager = NetworkManager()
    
    private enum FontLabel {
        static let dateLabelFont: CGFloat = 14
        static let weekDayLabelFont: CGFloat = 17
    }
    
    private let firstMargin: CGFloat = 10
    private let secondMargin: CGFloat = 5
    private let iconSize: CGFloat = 30
    
    static let reuseId = "ForecastTableViewCell"
    
    weak var viewModel: ForecastCellViewModel! {
        didSet {
            if let date = getDateFromString(viewModel?.dateString) {
                dateLabel.text = getStringFromDate(date)
                weekDayLabel.text = getWeekdayDate(date)
            }
            self.networkManager.fetchConditionImage(viewModel?.iconString ?? "", view: iconView) { image in
                self.iconView.addSubview(image)
            }
            
            self.minTemperatureLabel.text = (viewModel?.minTemperatureString ?? "") + "°"
            self.maxTemperatureLabel.text = (viewModel?.maxTemperatureString ?? "") + "°"
        }
    }
    
    var dateLabel: UILabel = {
        var label = UILabel()
        label.font = .boldSystemFont(ofSize: FontLabel.dateLabelFont)
        label.textColor = .systemGray2
        return label
    }()
    
    var weekDayLabel: UILabel = {
        var label = UILabel()
        label.font = .boldSystemFont(ofSize: FontLabel.weekDayLabelFont)
        label.textColor = .black
        return label
    }()
    
    var iconView: UIView = {
        var view = UIView()
        return view
    }()
    
    var minTemperatureLabel: UILabel = {
        var label = UILabel()
        label.textColor = .systemGray
        return label
    }()
    
    var maxTemperatureLabel: UILabel = {
        var label = UILabel()
        label.textColor = .black
        return label
    }()
    
    var stackTemperature: UIStackView = {
        var stack = UIStackView()
        stack.axis = .horizontal
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private func getDateFromString(_ stringDate: String?) -> Date? {
        guard let stringDate = stringDate else { return nil }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: stringDate) else {
            print("Error date format")
            return nil
        }
        return date
    }
    
    private func getStringFromDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "dd MMMM"
        return dateFormatter.string(from: date)
    }
    
    private func getWeekdayDate(_ date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ru_RU")
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date).capitalized
    }
    
    private func setupConstraints() {
        
        [dateLabel, weekDayLabel, iconView, stackTemperature].forEach {
            addSubview($0)
        }
        
        [maxTemperatureLabel, minTemperatureLabel].forEach {
            stackTemperature.addArrangedSubview($0)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(secondMargin)
            make.leading.equalToSuperview().inset(firstMargin)
        }
        
        weekDayLabel.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(secondMargin)
            make.leading.equalToSuperview().inset(firstMargin)
        }
        
        stackTemperature.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(firstMargin)
            make.trailing.equalToSuperview().inset(firstMargin)
        }
        
        iconView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(firstMargin)
            make.trailing.equalTo(stackTemperature.snp.leading).offset(-firstMargin)
            make.height.width.equalTo(iconSize)
        }
    }
}
