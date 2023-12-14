//
//  MenuItem.swift
//  RestaurantApp
//
//  Created by Tradd McCorkle on 12/11/23.
//

import Foundation

struct MenuItem: Codable, Identifiable {
    var id = UUID()
    var title: String
    var description: String
    var image: String
    var price: String
    var category: String
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case description = "description"
        case price = "price"
        case image = "image"
        case category = "category"
    }
}
