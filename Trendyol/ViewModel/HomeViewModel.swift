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

    func loadHomeData(completion: @escaping () -> ()) {
        if let path = Bundle.main.path(forResource: "shop", ofType: "json") {
            do {
                // JSON dosyasını okuma
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                
                // Veriyi decode etme
                let decoder = JSONDecoder()
                homeData = try decoder.decode(HomeModel.self, from: data)
                
                // JSON dosyasının doğru şekilde yüklendiğini ve decode edildiğini kontrol etme
                print("HomeData Loaded Successfully: \(homeData?.items ?? [])")
                
                // Completion fonksiyonunu ana iş parçacığında çağırıyoruz
                DispatchQueue.main.async {
                    completion()
                }
            } catch {
                // Hata mesajlarını kontrol etme
                errorMessage = "Failed to load data: \(error.localizedDescription)"
                print(errorMessage ?? "Unknown Error")
                
                DispatchQueue.main.async {
                    completion()
                }
            }
        } else {
            // JSON dosyasının bulunamaması durumunda
            errorMessage = "JSON file not found"
            print(errorMessage ?? "Unknown Error")
            
            DispatchQueue.main.async {
                completion()
            }
        }
    }

    func getCategories() -> [Category] {
        return homeData?.items.flatMap { $0.categories ?? [] } ?? []
    }

    func categoriesNumberOfRowsInSection(section: Int) -> Int  {
        return getCategories().count
    }

    func categoriesCellForRowAt(indexPath: IndexPath) -> Category {
        return getCategories()[indexPath.row]
    }

    func getProductsForCategory(index: Int) -> [Product] {
        let category = getCategories()[index]
        return category.products ?? []
    }

    func getProducts() -> [Product] {
        return homeData?.items.flatMap { $0.categories?.flatMap { $0.products ?? [] } ?? [] } ?? []
    }

    func getErrorMessage() -> String? {
        return errorMessage
    }
}
