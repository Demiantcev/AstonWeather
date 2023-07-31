//
//  Weather.swift
//  AstonWeatherApplication
//
//  Created by Кирилл Демьянцев on 19.07.2023.
//

import Foundation

struct Weather {
    
    var name: String = "Название"
    var temperature: Double = 0.0
    var temperatureString: String {
        return String(format: "%.0f", temperature)
    }
    var conditionIcon: String = ""
    var url: String = ""
    var condition: String = ""
    var pressureMm: Int = 0
    var windSpeed: Double = 0.0
    var daytime: String = ""
    var forecast: [Forecast] = []
    
    var conditionString: String {
        switch condition {
        case "clear" :                  return "Ясно"
        case "partly-cloudy" :          return "Малооблачно"
        case "cloudy" :                 return "Облачно с прояснениями"
        case "overcast" :               return "Пасмурно"
        case "drizzle" :                return "Морось"
        case "light-rain" :             return "Небольшой дождь"
        case "rain" :                   return "Дождь"
        case "moderate-rain" :          return "Умеренно сильный дождь"
        case "heavy-rain" :             return "Сильный дождь"
        case "continuous-heavy-rain" :  return "Длительный сильный дождь"
        case "showers" :                return "Ливень"
        case "wet-snow" :               return "Дождь со снегом"
        case "light-snow" :             return "Небольшой снег"
        case "snow" :                   return "Снег"
        case "snow-showers" :           return "Снегопад"
        case "hail" :                   return "Град"
        case "thunderstorm" :           return "Гроза"
        case "thunderstorm-with-rain" : return "Дождь с грозой"
        case "thunderstorm-with-hail" : return "Гроза с градом"
            
        default:
            return "Загрузка..."
        }
    }
    
    init?(weatherData: WeatherData) {
        name = weatherData.geoObject?.city?.name ?? ""
        temperature = weatherData.fact?.temp ?? 0
        conditionIcon = weatherData.fact?.icon ?? ""
        url = weatherData.info?.url ?? ""
        condition = weatherData.fact?.condition ?? ""
        pressureMm = weatherData.fact?.pressureMm ?? 0
        windSpeed = weatherData.fact?.windSpeed ?? 0
        daytime = weatherData.fact?.daytime ?? ""
        forecast = weatherData.forecasts ?? []
    }
    init() {
    }
}
