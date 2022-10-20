//
//  DishesHeader.swift
//  PizzaApp
//
//  Created by Leysan Latypova on 19.10.2022.
//

import UIKit

class DishesHeader: UITableViewHeaderFooterView {
    
    var layout = UICollectionViewFlowLayout()
    lazy var collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
    
    var menuData: [MenuSection] = []
    var onMenuSectionSelected: ((Int) -> ())?
    
    func configCollectionView() -> Void {
        addSubview(collectionView)
        
        layout.scrollDirection = .horizontal
        layout.estimatedItemSize = CGSize(width: 60, height: 60)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 20)
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .systemGroupedBackground
        
        collectionView.allowsMultipleSelection = false
        collectionView.allowsSelection = true
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(MenuCollectionViewCell.self, forCellWithReuseIdentifier: "MenuCollectionViewCell")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.frame = self.bounds
    }
}

extension DishesHeader: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return menuData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MenuCollectionViewCell", for: indexPath) as? MenuCollectionViewCell else { fatalError() }
        let cellData = menuData[indexPath.row]
        cell.configureButton(with: cellData)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        onMenuSectionSelected?(indexPath.item)
    }
}

