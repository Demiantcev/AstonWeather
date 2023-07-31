//
//  WeatherData.swift
//  AstonWeatherApplication
//
//  Created by Кирилл Демьянцев on 19.07.2023.
//

import Foundation

struct WeatherData: Decodable {
    
    let info: Info?
    let fact: Fact?
    let geoObject: GeoObject?
    let forecasts: [Forecast]?
    
    enum CodingKeys: String, CodingKey {
        case info
        case geoObject = "geo_object"
        case fact
        case forecasts
    }
}

struct Info: Decodable {
    
    let url: String?
}

struct Fact: Decodable {
    
    let temp: Double?
    var temperatureString: String {
        return String(format: "%.0f", temp!)
    }
    let icon: String?
    let condition: String?
    let windSpeed: Double?
    let pressureMm: Int?
    let daytime: String?
    
    enum CodingKeys: String, CodingKey {
        case temp
        case icon
        case condition
        case windSpeed = "wind_speed"
        case pressureMm = "pressure_mm"
        case daytime
    }
}

struct Forecast: Decodable {
    let parts: Parts?
    let date: String?
}

struct Parts: Decodable {
    let day: Day?
}

struct Day: Decodable {
    
    let icon: String?
    let tempMin: Int?
    let tempMax: Int?
    
    enum CodingKeys: String, CodingKey {
        case icon
        case tempMin = "temp_min"
        case tempMax = "temp_max"
    }
}

struct GeoObject: Decodable {
    let city: City?
    
    enum CodingKeys: String, CodingKey {
        case city = "locality"
    }
}

struct City: Decodable {
    let name: String?
}
