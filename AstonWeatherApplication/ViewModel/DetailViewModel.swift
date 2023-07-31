//
//  DetailViewModel.swift
//  AstonWeatherApplication
//
//  Created by Кирилл Демьянцев on 30.07.2023.
//

import UIKit

final class DetailViewModel {
    
    private var cellsArray = [ForecastCellViewModel]()
    var netWorkWeatherManager = NetworkManager()
    
    var cityTitle: String!
    var conditionString: String!
    var windString: String!
    var pressureString: String!
    var temperatureString: String!
    var conditionImage: String!
    var dayTimeString: String!
    var forecast: [Forecast]!
    
    required init(weather: Weather) {
        self.cityTitle = weather.name
        self.conditionString = weather.conditionString
        self.windString = "\(weather.windSpeed)"
        self.pressureString = "\(weather.pressureMm)"
        self.temperatureString = weather.temperatureString
        self.conditionImage = weather.conditionIcon
        self.dayTimeString = weather.daytime
        self.forecast = weather.forecast
    }
    
    func update() {
        for weather in forecast {
            self.cellsArray.append(ForecastCellViewModel(forecast: weather))
        }
    }
    
    func downloadImage(view: UIView) {
        self.netWorkWeatherManager.fetchConditionImage(conditionImage, view: view) { image in
            view.addSubview(image)
        }
    }
    
    func numberOrRows() -> Int {
        return self.cellsArray.count
    }
    
    func cellViewModel(index: Int) -> ForecastCellViewModel? {
        guard index < cellsArray.count else { return nil }
        return cellsArray[index]
    }
}
    
