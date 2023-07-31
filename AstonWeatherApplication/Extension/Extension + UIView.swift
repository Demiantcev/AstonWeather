//
//  Extension + UIView.swift
//  AstonWeatherApplication
//
//  Created by Кирилл Демьянцев on 24.07.2023.
//

import UIKit
extension UIView {
    
    func backgroundDayTime(image: String) {
        let backgroundImage = UIImageView(frame: self.bounds)
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.clipsToBounds = true
        backgroundImage.image = UIImage(named: image)
        self.insertSubview(backgroundImage, at: 0)
    }
    
    func backgroundTableView(_ tableView: UITableView, image: String) {
        let image = UIImage(named: image)
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        tableView.backgroundView = imageView
        imageView.alpha = 0.3
    }
}
