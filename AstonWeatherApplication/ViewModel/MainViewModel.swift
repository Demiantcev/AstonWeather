//
//  MainViewModel.swift
//  AstonWeatherApplication
//
//  Created by Кирилл Демьянцев on 25.07.2023.
//

import UIKit
import CoreLocation

protocol IMainViewModel {
    
    func didTapButton(view: UIViewController, completion: @escaping () -> Void)
    func setCity(completion: @escaping () -> Void)
    func numberOrRows() -> Int
    func detailsViewModel(index: Int) -> DetailViewModel
    func deleteItem(_ indexPath: IndexPath)
    func cellViewModel(index: Int) -> MainWeatherCellViewModel?
}

final class MainViewModel: IMainViewModel {
    
    var netWorkWeatherManager = NetworkManager()
    var getCoordinate = GetCoordinate()
    var detailsViewModel: DetailViewModel!
    
    var cityName: [String] = ["Москва", "Екатеринбург", "Лос-Анджелес", "Гонолулу"]
    var citiesArray = [Weather]()
    var cellsArray = [MainWeatherCellViewModel]()
    var alert = AlertAction()
    
    func didTapButton(view: UIViewController, completion: @escaping () -> Void) {
        alert.alertPlusCity(view: view) { [self] (city) in
            addCity(city, completion: completion)
            completion()
        }
    }
    
    func setCity(completion: @escaping () -> Void) {
        cityName.forEach { addCity($0, completion: completion) }
    }
    
    func addCity(_ cityName: String, completion: @escaping () -> Void) {
        getCoordinate.getCoordinateFrom(city: cityName) { coordinate, error in
            guard let coordinates = coordinate, error == nil else { return }
            self.netWorkWeatherManager.fetchWeather(latitude: coordinates.latitude, longitude: coordinates.longitude) { weather in
                self.citiesArray.append(weather)
                self.cellsArray.append(MainWeatherCellViewModel(weather: weather))
            
                DispatchQueue.main.async {
                    completion()
                }
            }
        }
    }
    
    func numberOrRows() -> Int {
        return self.cellsArray.count
    }
    
    func deleteItem(_ indexPath: IndexPath) {
        self.cellsArray.remove(at: indexPath.row)
        self.citiesArray.remove(at: indexPath.row)
    }
    
    func detailsViewModel(index: Int) -> DetailViewModel {
        self.detailsViewModel = DetailViewModel(weather: citiesArray[index])
        return self.detailsViewModel
    }
    
    func cellViewModel(index: Int) -> MainWeatherCellViewModel? {
        guard index < cellsArray.count else { return nil }
        return cellsArray[index]
    }
}
