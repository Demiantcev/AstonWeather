//
//  NetworkManager.swift
//  AstonWeatherApplication
//
//  Created by Кирилл Демьянцев on 19.07.2023.
//

import UIKit
import SwiftSVG

struct NetworkManager {
    
    func fetchWeather(latitude: Double = 0, longitude: Double = 0, completionHandler: @escaping(Weather) -> Void) {
        
        let urlString = "https://api.weather.yandex.ru/v2/forecast?lat=\(latitude)&lon=\(longitude)"
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url, timeoutInterval: Double.infinity)
        request.addValue("\(apiKey)", forHTTPHeaderField: "X-Yandex-API-Key")
        request.httpMethod = "GET"
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                print(error)
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                print("http status code: \(httpResponse.statusCode)")
            }
            
            guard let data = data else {
                print(String(describing: error))
                return
            }
            
            if let weather = self.parseJSON(withData: data) {
                completionHandler(weather)
            }
        }
        task.resume()
    }
    
    private func parseJSON(withData data: Data) -> Weather? {
        let decoder = JSONDecoder()
        do {
            let weatherData = try decoder.decode(WeatherData.self, from: data)
            guard let weather = Weather(weatherData: weatherData) else {
                return nil
            }
            return weather
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return nil
    }
    
    // Тест Dispatch workItem
    func fetchConditionImage(_ icon: String, view: UIView, completionHandler: @escaping (UIView) -> Void) {
        
        let url = URL(string: "https://yastatic.net/weather/i/icons/blueye/color/svg/\(icon).svg")
        var data: Data?
        let queue = DispatchQueue.global(qos: .utility)
        
        let workItem = DispatchWorkItem(qos: .userInteractive) {
            data = try? Data(contentsOf: url!)
        }
        queue.async(execute: workItem)
        
        workItem.notify(queue: DispatchQueue.main) {
            if let imageData = data {
                let icon = UIView(SVGData: imageData) { image in
                    image.resizeToFit(view.bounds)
                }
                completionHandler(icon)
            }
        }
    }
}
