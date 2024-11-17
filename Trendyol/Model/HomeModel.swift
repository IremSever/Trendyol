//
//  HomeModel.swift
//  Trendyol
//
//  Created by IREM SEVER on 5.11.2024.

import Foundation

struct HomeModel: Codable {
    let items: [Item]
}

struct Item: Codable {
    let title, backgroundColor: String
    let categories: [Category]?
    let template: String
    let banners: [Banner]?
    let services: [Service]?
    let coupons: [Coupon]?
}

struct Banner: Codable {
    let image, text, date, campaignDetails: String?
    let backgroundColor: String
}

struct Category: Codable {
    let id: Int
    let name, image, url, backgroundColor: String?
    let products: [Product]
}

struct Product: Codable {
    let id: Int
    let name, description: String
    let price: Double
    let originalPrice, discount: Int
    let isPromotion: Bool
    let promotionPrice: Double
    let category: String
    let brand: String
    let brandImg: String
    let rating: Double
    let reviewsCount: Int
    let stockStatus: StockStatus
    let stickerIconImage: String?
    let flashSale, favoriteExclusive, popularCampaign: Bool
    let image: String?
    let attributes: Attributes
    let template: Template
    let flashProductionTimer: String? 
    let previouslyViewed: Bool?
}

struct Attributes: Codable {
    let material, color: String
    let sizes: [String]?
    let fit: String
}

enum StockStatus: String, Codable {
    case inStock = "In Stock"
}

enum Template: String, Codable {
    case product = "product"
    case categories = "categories"
    case banner = "banner"
}

struct Coupon: Codable {
    let icon, title: String?
    let availableCoupons: [AvailableCoupon]
}

struct AvailableCoupon: Codable {
    let amount, minimumPurchase, expirationDate: String
}

struct Service: Codable {
    let id: Int
    let name, icon, info, infoColor: String?
    let link: String
}
