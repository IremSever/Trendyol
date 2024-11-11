//
//  HomeModel.swift
//  Trendyol
//
//  Created by IREM SEVER on 5.11.2024.
//

import Foundation

struct HomeModel: Codable {
    let items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let title, backgroundColor: String
    let categories: [Category]?
    let template: String
    let banners: [Banner]?
    let services: [Service]?
    let promotion: [Promotion]?
    let coupons: [Coupon]?
}

// MARK: - Banner
struct Banner: Codable {
    let image, text, date, campaignDetails: String?
    let backgroundColor: String
}

// MARK: - Category
struct Category: Codable {
    let id: Int
    let name, image, url, backgroundColor, template: String
    let products: [Product]
}

// MARK: - Product
struct Product: Codable {
    let id: Int
    let name, description: String
    let price: Double
    let originalPrice, discount: Int
    let isPromotion: Bool
    let promotionPrice: Double
    let category, brand: String
    let rating: Double
    let reviewsCount: Int
    let stockStatus, stickerIconImage: String
    let flashSale, favoriteExclusive, popularCampaign: Bool
    let image: String?
    let attributes: Attributes
}

// MARK: - Attributes
struct Attributes: Codable {
    let material, color: String
    let sizes: [String]?
    let fit: String
}

// MARK: - Coupon
struct Coupon: Codable {
    let icon, title: String
    let availableCoupons: [AvailableCoupon]
}

// MARK: - AvailableCoupon
struct AvailableCoupon: Codable {
    let amount, minimumPurchase, expirationDate: String
}

// MARK: - Promotion
struct Promotion: Codable {
    let text, image, value: String
}

// MARK: - Service
struct Service: Codable {
    let id: Int
    let name, icon, info, infoColor: String
    let link: String
}
