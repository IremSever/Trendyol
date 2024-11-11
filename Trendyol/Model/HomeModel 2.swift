//
//  HomeModel 2.swift
//  Trendyol
//
//  Created by İrem Sever on 11.11.2024.
//


import Foundation

// Model for the HomeView data
struct HomeModel: Codable {
    let items: [Item]
    
    struct Item: Codable {
        let title: String
        let backgroundColor: String
        let template: String
        let categories: [Category]?
        let banners: [Banner]?
        let services: [Service]?
        let promotion: [Promotion]?
        let coupons: [Coupon]?
    }
    
    // Model for Category
    struct Category: Codable {
        let id: Int
        let name: String
        let image: String
        let url: String
        let backgroundColor: String
        let products: [Product]
        
        struct Product: Codable {
            let id: Int
            let name: String
            let description: String
            let price: Double
            let originalPrice: Double
            let discount: Int
            let isPromotion: Bool
            let promotionPrice: Double
            let category: String
            let brand: String
            let rating: Double
            let reviewsCount: Int
            let stockStatus: String
            let stickerIconImage: String
            let flashSale: Bool
            let favoriteExclusive: Bool
            let popularCampaign: Bool
            let image: String
            let attributes: Attributes
            
            struct Attributes: Codable {
                let material: String
                let color: String
                let sizes: [String]
                let fit: String
            }
        }
    }
    
    // Model for Banner
    struct Banner: Codable {
        let image: String
        let text: String
        let date: String
        let campaignDetails: String
        let backgroundColor: String
    }
    
    // Model for Service
    struct Service: Codable {
        let id: Int
        let name: String
        let icon: String
        let info: String
        let infoColor: String
        let link: String
    }
    
    // Model for Promotion
    struct Promotion: Codable {
        let text: String
        let image: String
        let value: String
    }
    
    // Model for Coupon
    struct Coupon: Codable {
        let icon: String
        let title: String
        let availableCoupons: [AvailableCoupon]
        
        struct AvailableCoupon: Codable {
            let amount: String
            let minimumPurchase: String
            let expirationDate: String
        }
    }
}
