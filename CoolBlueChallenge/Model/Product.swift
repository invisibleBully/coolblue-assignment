//
//  Product.swift
//  CoolBlueChallenge
//
//  Created by Jude on 10/08/2022.
//

import Foundation


struct ProductResponse : Codable {
    let products : [Product]?
    let currentPage : Int?
    let pageSize : Int?
    let totalResults : Int?
    let pageCount : Int?
    
    enum CodingKeys: String, CodingKey {
        case products = "products"
        case currentPage = "currentPage"
        case pageSize = "pageSize"
        case totalResults = "totalResults"
        case pageCount = "pageCount"
    }
    
}

struct PromoIcon : Codable {
    let text : String?
    let type : String?
    
    enum CodingKeys: String, CodingKey {
        case text = "text"
        case type = "type"
    }
    
}

struct ReviewSummary : Codable {
    let reviewAverage : Double?
    let reviewCount : Int?
    
    enum CodingKeys: String, CodingKey {
        case reviewAverage = "reviewAverage"
        case reviewCount = "reviewCount"
    }
    
}

struct ReviewInformation : Codable {
    let reviews : [String]?
    let reviewSummary : ReviewSummary?
    
    enum CodingKeys: String, CodingKey {
        case reviews = "reviews"
        case reviewSummary = "reviewSummary"
    }
}

struct Product: Identifiable, Codable {
    let id : Int
    let productName : String?
    let reviewInformation : ReviewInformation?
    let uSPs : [String]?
    let availabilityState : Int?
    let salesPriceIncVat : Double?
    let productImage : String?
    let coolbluesChoiceInformationTitle : String?
    let promoIcon : PromoIcon?
    let nextDayDelivery : Bool?
    
    enum CodingKeys: String, CodingKey {
        case id = "productId"
        case productName = "productName"
        case reviewInformation = "reviewInformation"
        case uSPs = "USPs"
        case availabilityState = "availabilityState"
        case salesPriceIncVat = "salesPriceIncVat"
        case productImage = "productImage"
        case coolbluesChoiceInformationTitle = "coolbluesChoiceInformationTitle"
        case promoIcon = "promoIcon"
        case nextDayDelivery = "nextDayDelivery"
    }
    
    static func formatAmount(_ price: Double) -> String?{
        let numberFormatter = NumberFormatter()
        numberFormatter.groupingSeparator = ","
        numberFormatter.groupingSize = 3
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.decimalSeparator = "."
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter.string(from: price as NSNumber)
    }
    
}
