//
//  HomeModel.swift
//  Trendyol
//
//  Created by IREM SEVER on 5.11.2024.
//

import Foundation

struct HomeModel: Codable {
    let list: [List]
}

struct List: Codable {
    let items: [Item]
}

struct Item: Codable {
    let title, backgroundColor: String?
    let categories: [Category]?
    let template: String
    let banners: [Banner]?
    let services: [Service]?
    let promotion: Promotion?
    let coupons: [Coupon]?
    let products: [Product]?
}

struct Banner: Codable {
    let image, text, date, campaignDetails: String?
    let backgroundColor: String?
}

struct Category: Codable {
    let id: Int
    let name, image, url, backgroundColor: String?
}

struct Coupon: Codable {
    let icon, title: String?
    let availableCoupons: [AvailableCoupon]?
}

struct AvailableCoupon: Codable {
    let amount, minimumPurchase, expirationDate: String?
}

struct Product: Codable {
    let id: Int?
    let name, description: String?
    let price, originalPrice, discount: Int?
    let category, brand: String?
    let rating: Double?
    let reviewsCount: Int?
    let stockStatus, stickerIconImage: String?
    let flashSale, favoriteExclusive, popularCampaign: Bool?
    let attributes: Attributes?
    let reviews: [Review]?
}

struct Attributes: Codable {
    let material, color, materialComposition, washingInstructions: String?
    let beltStatus, silhouette, length, pockets: String?
    let sleeveLength, neckType, age, packageContent: String?
    let sustainabilityDetails, fit, productType, liningStatus: String?
    let fabricType: String?
    let sizes: [String]?
}

struct Review: Codable {
    let username: String?
    let rating: Int?
    let comment, date: String?
}

struct Promotion: Codable {
    let text, image, value: String?
}

struct Service: Codable {
    let id: Int?
    let name, icon, info, infoColor: String?
    let link: String?
}

