//
//  Models.swift
//  PizzaApp
//
//  Created by Leysan Latypova on 18.10.2022.
//

import Foundation

//[[]]

enum ListSection {
    case banners([Banner])
    case category([MenuSection])
    case dishes([Dish])
    
    var items: [Any] {
        switch self {
        case .banners(let banners):
            return banners
        case .category(let category):
            return category
        case .dishes(let dishes):
            return dishes
        }
    }

}

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
