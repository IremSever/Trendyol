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
    
    func getItems() -> [Item] {
        return homeData?.list.first?.items ?? []
    }
    
    func getCategories(for item: Item) -> [Category] {
        return item.categories ?? []
    }
    
    func getBanners(for item: Item) -> [Banner] {
        return item.banners ?? []
    }
    
    func getServices(for item: Item) -> [Service] {
        return item.services ?? []
    }
    
    func getPromotion(for item: Item) -> Promotion? {
        return item.promotion
    }
    
    func getCoupons(for item: Item) -> [Coupon] {
        return item.coupons ?? []
    }
    
    func getProducts(for item: Item) -> [Product] {
        return item.products ?? []
    }
}
