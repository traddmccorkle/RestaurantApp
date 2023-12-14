//
//  MenuItem.swift
//  RestaurantApp
//
//  Created by Tradd McCorkle on 12/11/23.
//

import Foundation

struct MenuItem: Decodable {
    var title: String
    var description: String
    var image: String
    var price: String
    var category: String
}
