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

struct Item: Codable {
    let title: String
    let backgroundColor: String?
    let categories: [Category]?
    let banners: [Banner]?
    let services: [Service]?
    let promotion: Promotion?
    let coupons: [Coupon]?
    let template: String
}

struct Category: Codable {
    let id: Int
    let name, image, url, backgroundColor: String
    let products: [Product]?
}

struct Banner: Codable {
    let image, text, date, campaignDetails: String
    let backgroundColor: String
}

struct Service: Codable {
    let id: Int
    let name, icon, info, infoColor: String
    let link: String
}

struct Product: Codable {
    let id: Int
    let name, description: String
    let price: Double
    let originalPrice: Double
    let discount: Int
    let isPromotion: Bool
    let promotionPrice: Double
    let category, brand: String
    let rating: Double
    let reviewsCount: Int
    let stockStatus, stickerIconImage: String
    let flashSale, favoriteExclusive, popularCampaign: Bool
    let attributes: Attributes
}

struct Attributes: Codable {
    let material, color: String
    let sizes: [String]
    let fit: String
}

struct Promotion: Codable {
    let text, image, value: String
}

struct Coupon: Codable {
    let icon, title: String
    let availableCoupons: [AvailableCoupon]
}

struct AvailableCoupon: Codable {
    let amount, minimumPurchase, expirationDate: String
}
