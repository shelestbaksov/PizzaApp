//
//  Models.swift
//  PizzaApp
//
//  Created by Leysan Latypova on 18.10.2022.
//

import Foundation


enum CellModel {
    case collectionView(models: [Banner])
    case listView(models: [MenuItem])
}

//let response = ["banners": [Banner], "menu": [Menu]]
struct Banner {
    let imageUrl: String
}

struct Menu {
    let title: String
    let item: MenuItem
}

struct MenuItem {
    let name: String
    let imageUrl: String
    let description: String?
    let price: String
}
