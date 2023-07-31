//
//  Extension + Int.swift
//  AstonWeatherApplication
//
//  Created by Кирилл Демьянцев on 23.07.2023.
//

import Foundation
extension Int {
    
    func withSign() -> String {
        self > 0 ? "+\(self)" : "\(self)"
    }
}
