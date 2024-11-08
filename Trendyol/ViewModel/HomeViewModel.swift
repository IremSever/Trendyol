//
//  HomeViewModel.swift
//  Trendyol
//
//  Created by IREM SEVER on 5.11.2024.
//

import Foundation

class HomeViewModel {
    private var homeData: HomeModel?
    private var errorMessage: String?

    func loadHomeData() {
        if let path = Bundle.main.path(forResource: "shop", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(filePath: path))
                let decoder = JSONDecoder()
                homeData = try decoder.decode(HomeModel.self, from: data)
            } catch {
                errorMessage = "Failed to load data: \(error.localizedDescription)"
            }
        }  else {
            errorMessage = "JSON file not found"
        }
    }
    
    func getCategories() -> [Category]? {
        return homeData?.list.first?.items.flatMap { $0.categories ?? [] }
    }
    func getProducts() -> [Product]? {
        return homeData?.list.first?.items.flatMap { $0.products ?? [] }
    }
    
}
