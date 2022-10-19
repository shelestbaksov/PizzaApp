//
//  TableViewController.swift
//  PizzaApp
//
//  Created by Leysan Latypova on 18.10.2022.
//

import UIKit

class MainPageTableViewController: UITableViewController {
    
    private let service = MenuService()
    private var sections: [[Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = .none
        
        service.fetchMenu { [weak self] result in
            switch result {
            case .success(let resultDict):
                
                let newSections: [[Any]] = [
                    [resultDict.banners],
                    //[resultDict.menu],
                    resultDict.menu.reduce([]) { $0 + $1.items }
                ]
                
                DispatchQueue.main.async {
                    self?.sections = newSections
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let sectionItems = sections[indexPath.section]
        let item = sectionItems[indexPath.row]
        
        if let banners = item as? [Banner] {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: BannerTableViewCell.identifier, for: indexPath) as? BannerTableViewCell else {
                fatalError()
            }
            cell.selectionStyle = .none
            cell.banners = banners
            return cell
        }
//        else if let menuSections = item as? [MenuSection] {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "2", for: indexPath)
//            return cell
//        }
        else if let dish = item as? Dish {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: DishTableViewCell.identifier,
                for: indexPath
            ) as? DishTableViewCell else { fatalError() }
            guard let imageUrl = URL(string: dish.imageUrl) else { fatalError() }
            
            cell.itemImageView.image = nil
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: imageUrl) {
                    DispatchQueue.main.async {
                        cell.itemImageView.image = UIImage(data: data)
                    }
                }
            }
            cell.selectionStyle = .none
            cell.layer.cornerRadius = 20
            cell.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
            cell.itemTitleLabel.text = dish.title
            cell.itemDescriptionLabel.text = dish.description
            cell.itemPriceLabel.text = dish.price
            
            return cell
        } else {
            fatalError()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }
}
