//
//  MainViewController.swift
//  AstonWeatherApplication
//
//  Created by Кирилл Демьянцев on 19.07.2023.
//

import UIKit
import SnapKit
import CoreLocation

final class MainViewController: UIViewController {
    
    private var viewModel: IMainViewModel = MainViewModel()
    
    private let heightCell: CGFloat = 50
    private let backgroundImage: String = "Map"
    
    private var tableView: UITableView = {
        var table = UITableView()
        table.register(MainWeatherViewCell.self, forCellReuseIdentifier: MainWeatherViewCell.reuseId)
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.setCity {
            self.tableView.reloadData()
        }
        tableView.delegate = self
        tableView.dataSource = self
        setupConstraint()
        setupNavigation()
        view.backgroundTableView(tableView, image: backgroundImage)
    }
    
    private func setupViewGradient(withColors colors: [CGColor], opacity: Float, view: UITableView) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = colors
        gradientLayer.opacity = opacity
        gradientLayer.frame = view.frame
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    @objc func addCity() {
        viewModel.didTapButton(view: self) {
            self.tableView.reloadData()
        }
    }
    
    private func setupNavigation() {
        definesPresentationContext = true
        navigationItem.hidesSearchBarWhenScrolling = false
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addCity))
        navigationItem.rightBarButtonItems = [add]
    }
    
    private func setupConstraint() {
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension MainViewController: UITableViewDataSource ,UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOrRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MainWeatherViewCell.reuseId, for: indexPath) as! MainWeatherViewCell
        cell.backgroundColor = .clear
        
        cell.viewModel = self.viewModel.cellViewModel(index: indexPath.row)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.viewModel = viewModel.detailsViewModel(index: indexPath.row)
        navigationController?.pushViewController(detailVC, animated: true)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {

        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { (_, _, completionHandler) in
            self.viewModel.deleteItem(indexPath)
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        heightCell
    }
}
