//
//  GetCoordinate.swift
//  AstonWeatherApplication
//
//  Created by Кирилл Демьянцев on 31.07.2023.
//

import Foundation
import CoreLocation

final class GetCoordinate {
    func getCoordinateFrom(city: String, completion: @escaping(_ coordinate: CLLocationCoordinate2D?, _ error: Error?) -> Void ) {
        CLGeocoder().geocodeAddressString(city) { (placemark, error) in
            completion(placemark?.first?.location?.coordinate, error)
        }
    }
}
