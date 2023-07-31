//
//  DetailViewController.swift
//  AstonWeatherApplication
//
//  Created by Кирилл Демьянцев on 19.07.2023.
//

import UIKit
import SnapKit
import SwiftSVG

final class DetailViewController: UIViewController {
    
    enum ImageName {
        static let windImage: String = "wind"
        static let pressureImage: String = "barometer"
        static let day: String = "Day"
        static let night: String = "Night"
    }
    
    enum FontSize {
        static let firstSize: CGFloat = 15
        static let secondSize: CGFloat = 30
    }
    private let heightCell: CGFloat = 50
    private let imageWeatherSize: CGFloat = 100
    private let margin: CGFloat = 10
    private let secondMargin: CGFloat = 20
    private let heightTableView: CGFloat = 350
    
    weak var viewModel: DetailViewModel! {
        didSet {
            viewModel.update()
        }
    }
    var forecast = [Forecast]()
    
    var imageWeather = UIView()
    
    let conditionLabel: UILabel = {
        var label = UILabel()
        label.font = .boldSystemFont(ofSize: FontSize.firstSize)
        label.textColor = .white
        return label
    }()
    
    let temperatureCityLabel: UILabel = {
        var label = UILabel()
        label.font = .boldSystemFont(ofSize: FontSize.secondSize)
        label.textColor = .white
        return label
    }()
    
    let windImage: UIImageView = {
        var image = UIImageView()
        image.image = UIImage(systemName: ImageName.windImage)
        return image
    }()
    
    let windSpeedLabel: UILabel = {
        var label = UILabel()
        label.font = .boldSystemFont(ofSize: FontSize.firstSize)
        label.textColor = .white
        return label
    }()
    
    let pressureImage: UIImageView = {
        var image = UIImageView()
        image.image = UIImage(systemName: ImageName.pressureImage)
        return image
    }()
    
    let pressureMmLabel: UILabel = {
        var label = UILabel()
        label.font = .boldSystemFont(ofSize: FontSize.firstSize)
        label.textColor = .white
        return label
    }()
    
    var tableView: UITableView = {
        var tableView = UITableView()
        var table = UITableView()
        table.register(ForecastTableViewCell.self, forCellReuseIdentifier: ForecastTableViewCell.reuseId)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        setupConstraints()
        refresh()
        tableView.dataSource = self
        tableView.delegate = self
        
        self.tableView.reloadData()
    }
    
    private func refresh() {
        self.title = viewModel?.cityTitle
        conditionLabel.text = viewModel?.conditionString
        temperatureCityLabel.text = (viewModel?.temperatureString ?? "") + "°C"
        windSpeedLabel.text = (viewModel?.windString ?? "") + "м/c"
        pressureMmLabel.text = (viewModel?.pressureString ?? "") + "мм рт.ст"
        viewModel?.downloadImage(view: imageWeather)
        if viewModel?.dayTimeString == "d" {
            view.backgroundDayTime(image: ImageName.day)
        } else {
            view.backgroundDayTime(image: ImageName.night)
        }
        self.forecast = viewModel.forecast ?? []
    }
    
    private func setupConstraints() {
        
        [imageWeather, conditionLabel, temperatureCityLabel, windSpeedLabel, windImage, pressureMmLabel, pressureImage, tableView].forEach {
            view.addSubview($0)
        }
        
        imageWeather.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.height.width.equalTo(imageWeatherSize)
            make.centerX.equalToSuperview()
        }
        conditionLabel.snp.makeConstraints { make in
            make.top.equalTo(temperatureCityLabel.snp.bottom).offset(margin)
            make.centerX.equalToSuperview()
        }
        temperatureCityLabel.snp.makeConstraints { make in
            make.top.equalTo(imageWeather.snp.bottom).inset(-secondMargin)
            make.centerX.equalToSuperview()
        }
        windImage.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(margin)
            make.centerY.equalTo(windSpeedLabel.snp.centerY)
        }
        windSpeedLabel.snp.makeConstraints { make in
            make.leading.equalTo(windImage.snp.trailing).inset(-margin)
            make.centerY.equalTo(temperatureCityLabel.snp.centerY)
        }
        pressureMmLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-margin)
            make.centerY.equalTo(pressureImage.snp.centerY)
        }
        pressureImage.snp.makeConstraints { make in
            make.trailing.equalTo(pressureMmLabel.snp.leading).offset(-margin)
            make.centerY.equalTo(temperatureCityLabel.snp.centerY)
        }
        tableView.snp.makeConstraints { make in
            make.top.equalTo(conditionLabel.snp.bottom).offset(margin)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(heightTableView)
        }
    }
}
extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOrRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ForecastTableViewCell.reuseId, for: indexPath) as! ForecastTableViewCell
        cell.viewModel = viewModel.cellViewModel(index: indexPath.row)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        heightCell
    }
}
