//
//  HomeViewModel.swift
//  Trendyol
//
//  Created by IREM SEVER on 5.11.2024.
//
// HomeViewModel.swift
import Foundation

class HomeViewModel {
    var homeData: HomeModel?
    private var errorMessage: String?
    var selectedCategoryIndex: Int = 0

    func loadHomeData(completion: @escaping () -> ()) {
        if let path = Bundle.main.path(forResource: "shop", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                let decoder = JSONDecoder()
                homeData = try decoder.decode(HomeModel.self, from: data)
                print("HomeData Loaded Successfully: \(homeData?.items ?? [])")
                DispatchQueue.main.async { completion() }
            } catch {
                errorMessage = "Failed to load data: \(error.localizedDescription)"
                print(errorMessage ?? "Unknown Error")
                DispatchQueue.main.async { completion() }
            }
        } else {
            errorMessage = "JSON file not found"
            print(errorMessage ?? "Unknown Error")
            DispatchQueue.main.async { completion() }
        }
    }

    // Categories
    func getCategories() -> [Category] {
        return homeData?.items.flatMap { $0.categories ?? [] } ?? []
    }

    func categoriesNumberOfRowsInSection(section: Int) -> Int {
        return getCategories().count
    }

    func categoriesCellForRowAt(indexPath: IndexPath) -> Category {
        return getCategories()[indexPath.row]
    }

    // Selected Category and Products
    func setSelectedCategoryIndex(_ index: Int) {
        selectedCategoryIndex = index
    }
    func getSelectedCategoryProducts() -> [Product] {
        let categories = getCategories()
        guard selectedCategoryIndex < categories.count else { return [] }
        return categories[selectedCategoryIndex].products
    }

    // Template
    func getTemplateType(for section: Int) -> String? {
        return homeData?.items[section].template
    }

    func templateNumberOfRowsInSection(section: Int) -> Int {
        return getSelectedCategoryProducts().count
    }

    func templateCellForRowAt(indexPath: IndexPath) -> Product {
        return getSelectedCategoryProducts()[indexPath.row]
    }

    //Banner
    func getBanners() -> [Banner] {
        return homeData?.items.flatMap { $0.banners ?? [] } ?? []
    }
    func bannerNumberOfRowsInSection(section: Int) -> Int  {
        return getBanners().count
    }
    func bannerCellForRowAt(indexPath: IndexPath) -> Banner {
        return getBanners()[indexPath.row]
    }
    
    //Service
    func getServices() -> [Service] {
        return homeData?.items.flatMap { $0.services ?? [] } ?? []
    }
    func serviceNumberOfRowsInSection(section: Int) -> Int  {
        return getServices().count
    }
    func serviceCellForRowAt(indexPath: IndexPath) -> Service {
        return getServices()[indexPath.row]
    }
   
    //Coupon
    func getCoupons() -> [Coupon] {
        return homeData?.items.flatMap { $0.coupons ?? [] } ?? []
    }
    func couponNumberOfRowsInSection(section: Int) -> Int  {
        return getCoupons().count
    }
    func couponCellForRowAt(indexPath: IndexPath) -> Coupon {
        return getCoupons()[indexPath.row]
    }
    
    //Product
    func getGroupedProductsByBrand() -> [[Product]] {
           var groupedByBrand: [[Product]] = []
           
           let allProducts = getCategories().flatMap { $0.products }
           let grouped = Dictionary(grouping: allProducts, by: { $0.brand })
           
           for (_, products) in grouped {
               groupedByBrand.append(products)
           }
           
           return groupedByBrand
       }
    
    func getPromotionalProducts() -> [Product] {
        let allProducts = getCategories().flatMap { $0.products }
        return allProducts.filter { $0.isPromotion }
    }
    
    func getProductsGroupedByCategory(categoryName: String) -> [Product] {
        let allProducts = getCategories().flatMap { $0.products }
        return allProducts.filter { $0.category == categoryName }
    }
    
    func getErrorMessage() -> String? {
        return errorMessage
    }
}
