//
//  Product.swift
//  FakeStore
//
//  Created by Carl-Johan Heinze on 2023-02-19.
//

import Foundation

// MARK: - Product
struct Product: Codable {
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: Category
    let image: String
    let rating: Rating
}

enum Category: String, Codable {
    case electronics = "electronics"
    case jewelery = "jewelery"
    case mensClothing = "men's clothing"
    case womensClothing = "women's clothing"
    case unknown
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let category = try? container.decode(String.self)
        
        switch category {
        case Category.electronics.rawValue:
            self = .electronics
        case Category.jewelery.rawValue:
            self = .jewelery
        case Category.mensClothing.rawValue:
            self = .mensClothing
        case Category.womensClothing.rawValue:
            self = .womensClothing
        default:
            self = .unknown
        }
    }
}

// MARK: - Rating
struct Rating: Codable {
    let rate: Double
    let count: Int
}

extension Rating {
    var formattedRate: String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .decimal
        formatter.maximumSignificantDigits = 2
        
        return formatter.string(from: self.rate as NSNumber) ?? String(format: "%.2f", self.rate)
    }
}
