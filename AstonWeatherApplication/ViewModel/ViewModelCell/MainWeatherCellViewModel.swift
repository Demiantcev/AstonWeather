//
//  MainWeatherCellViewModel.swift
//  AstonWeatherApplication
//
//  Created by Кирилл Демьянцев on 31.07.2023.
//

import Foundation

final class MainWeatherCellViewModel {
    var cityTitle: String!
    var temperatureString: String!
    var conditionString: String!
    
    required init(weather: Weather) {
        self.cityTitle = weather.name
        self.conditionString = weather.conditionString
        self.temperatureString = weather.temperatureString + "°C"
    }
}
