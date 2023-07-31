//
//  AddCity.swift
//  AstonWeatherApplication
//
//  Created by Кирилл Демьянцев on 19.07.2023.
//

import UIKit

final class AlertAction {
    
    private let cityText = "Город"
    private let placeholderText = "Введите название города"
    private let okText = "OK"
    private let cancelText = "Отмена"
    
    func alertPlusCity(view: UIViewController, completionHandler: @escaping (String) -> Void) {
        
        let alertController = UIAlertController(title: cityText, message: nil, preferredStyle: .alert)
        let alertOk = UIAlertAction(title: okText, style: .default) { (action) in
            
            let text = alertController.textFields?.first
            guard let text = text?.text else { return }
            completionHandler(text)
        }
        alertController.addTextField { [self] (tf) in
            tf.placeholder = placeholderText
        }
        
        let alertCancel = UIAlertAction(title: cancelText, style: .default) { (_) in}
        
        alertController.addAction(alertOk)
        alertController.addAction(alertCancel)
        
        view.present(alertController, animated: true, completion: nil)
    }
}

