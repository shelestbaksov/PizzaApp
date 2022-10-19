//
//  CollectionViewCell.swift
//  PizzaApp
//
//  Created by Leysan Latypova on 19.10.2022.
//

import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    var button: UIButton = UIButton()

    func configureButton(with menuSection: MenuSection) -> Void {
        
        addSubview(button)
        
        button.setTitle(menuSection.title, for: .normal)
        button.backgroundColor = .lightGray
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 20, right: 20)
        button.layer.cornerRadius = 18
        button.clipsToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 14)
        
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        setButtonConstraintes()
    }
    
    func setButtonConstraintes() {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40).isActive = true
        button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 30).isActive = true
    }
    
    @objc func buttonTapped() {
    
    }
}
