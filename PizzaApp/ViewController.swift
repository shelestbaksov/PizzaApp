//
//  ViewController.swift
//  PizzaApp
//
//  Created by Leysan Latypova on 18.10.2022.
//

import UIKit

class ViewController: UIViewController {
    
    private let table: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.register(CollectionTableViewCell.self, forCellReuseIdentifier: CollectionTableViewCell.identifier)
        return table
    }()
    
    var models = [CellModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpModels()
        
        view.addSubview(table)
        table.delegate = self
        table.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = view.bounds
    }
    
    func setUpModels() {
        models.append(.collectionView(models: [
            Banner(imageUrl: "https://cdn.papajohns.ru//images/banners/a11d7332c41d80fa427dc2a33fd07994.webp"),
            Banner(imageUrl: "https://cdn.papajohns.ru//images/banners/a11d7332c41d80fa427dc2a33fd07994.webp"),
            Banner(imageUrl: "https://cdn.papajohns.ru//images/banners/a11d7332c41d80fa427dc2a33fd07994.webp"),
            Banner(imageUrl: "https://cdn.papajohns.ru//images/banners/a11d7332c41d80fa427dc2a33fd07994.webp"),
            Banner(imageUrl: "https://cdn.papajohns.ru//images/banners/a11d7332c41d80fa427dc2a33fd07994.webp"),
            Banner(imageUrl: "https://cdn.papajohns.ru//images/banners/a11d7332c41d80fa427dc2a33fd07994.webp")
        ]
                                     ))
        models.append(.listView(models: [
            Item(name: "Пицца",
                 imageUrl: "https://cdn.papajohns.ru//images/banners/a11d7332c41d80fa427dc2a33fd07994.webp",
                 description: "Самая вкусная пицца на свете",
                 price: "от 100")
        ]))
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch models[section] {
        case .collectionView(models: let models):
            return models.count
        case .listView(models: let models):
            return models.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch models[indexPath.section] {
        case .listView(models: let models):
            let model = models[indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
            let url = URL(string: model.imageUrl)!
            if let data = try? Data(contentsOf: url) {
                cell.imageView?.image = UIImage(data: data)
            }
            cell.textLabel?.text = model.name
            return cell
        case .collectionView(models: let models):
            let cell = tableView.dequeueReusableCell(withIdentifier: CollectionTableViewCell.identifier, for: indexPath) as! CollectionTableViewCell
            cell.configure(with: models)
            return cell
        }
        
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
