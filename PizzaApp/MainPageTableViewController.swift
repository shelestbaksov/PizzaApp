//
//  TableViewController.swift
//  PizzaApp
//
//  Created by Leysan Latypova on 18.10.2022.
//

import UIKit

class MainPageTableViewController: UITableViewController {
    
    private let service = MenuService()
    private var menuSections = [MenuSection]()
    override func viewDidLoad() {
        super.viewDidLoad()
        service.fetchMenu { [weak self] result in
            switch result {
            case .success(let menuSections):
                self?.menuSections = menuSections
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return menuSections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuSections[section].items.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let dish = menuSections[indexPath.section].items[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: MenuItemTableViewCell.identifier,
            for: indexPath
        ) as? MenuItemTableViewCell else { fatalError() }
        guard let imageUrl = URL(string: dish.imageUrl) else { fatalError() }
        if let data = try? Data(contentsOf: imageUrl) {
            DispatchQueue.main.async {
                cell.itemImageView.image = UIImage(data: data)
            }
        }
        cell.itemTitleLabel.text = dish.title
        cell.itemDescriptionLabel.text = dish.description
        cell.itemPriceLabel.text = dish.price
        
        return cell
    }
    

}
