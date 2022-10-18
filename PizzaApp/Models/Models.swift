//
//  Models.swift
//  PizzaApp
//
//  Created by Leysan Latypova on 18.10.2022.
//

import Foundation


//enum CellModel {
//    case collectionView(models: [Banner])
//    case listView(models: [MenuItem])
//}

//let response = ["banners": [Banner], "menu": [Menu]]


struct APIResponse: Codable {
    let banners: [Banner]
    let menu: [MenuSection]
}

struct Banner: Codable {
    let imageUrl: String
}

struct MenuSection: Codable {
    let title: String
    let items: [Dish]
}

struct Dish: Codable {
    let title: String
    let imageUrl: String
    let description: String?
    let price: String
}
