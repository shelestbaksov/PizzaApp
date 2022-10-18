//
//  MenuService.swift
//  PizzaApp
//
//  Created by Leysan Latypova on 18.10.2022.
//

import Foundation

enum MenuServiceError: Error {
    case invalidURL
    case noData
    case decodingError
}

class MenuService {
    
    func fetchMenu(completion: @escaping (Result<[MenuSection], Error>) -> Void) {
        guard let url = URL(string: "https://raw.githubusercontent.com/shelestbaksov/PizzaApp/main/pizza_api.json") else {
            completion(.failure(MenuServiceError.invalidURL))
            return
        }
        URLSession.shared.dataTask(with: url) { menuData, _, error in
            guard let menuData = menuData else {
                completion(.failure(MenuServiceError.noData))
                return
            }
            
            do {
                let resultDict = try JSONDecoder().decode(APIResponse.self, from: menuData)
                let menuSections = resultDict.menu
                DispatchQueue.main.async {
                    completion(.success(menuSections))
                }
            } catch {
                completion(.failure(MenuServiceError.decodingError))
            }
        }.resume()
    }
}
