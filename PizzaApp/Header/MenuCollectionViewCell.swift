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
        button.setTitleColor(.white, for: .highlighted)
        button.setTitleColor(.myPink, for: .normal)
        button.backgroundColor = .clear
        button.layer.borderWidth = 1
        button.layer.borderColor = CGColor(red: 253/255, green: 58/255, blue: 105/255, alpha: 1)
        button.contentEdgeInsets = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)
        button.layer.cornerRadius = 18
        button.clipsToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 14)
        
        button.addTarget(self, action: #selector(holdRelease), for: .touchUpInside);
//        button.addTarget(self, action: #selector(heldDown), for: .touchDown)
//        button.addTarget(self, action: #selector(buttonHeldAndReleased), for: .touchDragExit)
        
        setButtonConstraintes()
    }
    
    //target functions
//    @objc func heldDown()
//    {
//        button.backgroundColor = .myPink
//    }

    @objc func holdRelease()
    {
        if button.backgroundColor == .clear {
            button.backgroundColor = .myPink
        } else {
            button.backgroundColor = .clear
        }
        print(button.state)
    }

//    @objc func buttonHeldAndReleased(){
//        button.backgroundColor = .myPink
//    }
    
    func setButtonConstraintes() {
        button.translatesAutoresizingMaskIntoConstraints = false
        button.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        button.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 0).isActive = true
        button.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        button.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10).isActive = true
    }
}

extension UIColor {
    static let myPink = UIColor(red: 253/255, green: 58/255, blue: 105/255, alpha: 1)
}
