//
//  ForecastCellViewModel.swift
//  AstonWeatherApplication
//
//  Created by Кирилл Демьянцев on 31.07.2023.
//

import Foundation

final class ForecastCellViewModel {
    var dateString: String!
    var weakDayString: String!
    var minTemperatureString: String!
    var maxTemperatureString: String!
    var iconString: String!
    
    required init(forecast: Forecast) {
        self.dateString = forecast.date
        self.weakDayString = forecast.date
        self.minTemperatureString = "\(forecast.parts?.day?.tempMin?.withSign() ?? "")"
        self.maxTemperatureString = "\(forecast.parts?.day?.tempMax?.withSign() ?? "")"
        self.iconString = forecast.parts?.day?.icon
    }
    
    
}
