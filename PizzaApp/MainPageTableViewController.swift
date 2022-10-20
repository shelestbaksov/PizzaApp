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
    private var menuSections: [MenuSection] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = .none
        
        service.fetchMenu { [weak self] result in
            switch result {
            case .success(let resultDict):
                
                let newSections: [[Any]] = [
                    [resultDict.banners],
                    resultDict.menu.reduce([]) { $0 + $1.items }
                ]
                
                
                DispatchQueue.main.async {
                    self?.sections = newSections
                    self?.menuSections = resultDict.menu
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
        tableView.register(DishesHeader.self, forHeaderFooterViewReuseIdentifier: "Header")
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
        } else if let dish = item as? Dish {
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
            
            cell.itemDescriptionLabel.text = dish.description
            cell.itemTitleLabel.text = dish.title
            cell.itemPriceLabel.text = dish.price
            cell.itemPriceLabel.layer.borderWidth = 1
            cell.itemPriceLabel.layer.cornerRadius = 10
            cell.itemPriceLabel.layer.borderColor = CGColor(red: 253/255, green: 58/255, blue: 105/255, alpha: 1)
            
            return cell
        } else {
            fatalError()
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "Header") as? DishesHeader else { fatalError() }
            header.configCollectionView()
            header.backgroundColor = .clear
            header.menuData = menuSections
            header.onMenuSectionSelected = { [weak self] selectedIndex in
                guard let self = self else { return }
                
                let numberOfItemsInSectionsBeforeSelected: Int = self.menuSections.prefix(selectedIndex).reduce(0) { $0 + $1.items.count }
                
                print(numberOfItemsInSectionsBeforeSelected)
                self.tableView.scrollToRow(at: IndexPath(row: numberOfItemsInSectionsBeforeSelected, section: section), at: .top, animated: true)
            }
            return header
        } else {
            return nil
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 60
        } else {
            return 0
        }
    }
}
