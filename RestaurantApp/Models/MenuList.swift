//
//  MenuList.swift
//  RestaurantApp
//
//  Created by Tradd McCorkle on 12/11/23.
//

import Foundation
import CoreData

struct MenuList: Codable {
    let menu: [MenuItem]
    
    enum CodingKeys: String, CodingKey {
        case menu = "menu"
    }
    
    static func getMenuData(viewContext: NSManagedObjectContext) async {
        // Clears existing Dish data before fetching and storing new data
        PersistenceController.shared.clear()

        do {
            let url = URL(string: "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json")!
            let urlSession = URLSession.shared
            let (data, _) = try await urlSession.data(from: url)
            let fullMenu = try JSONDecoder().decode(MenuList.self, from: data)
            fullMenu.menu.forEach { menuItem in
                let dish = Dish(context: viewContext)
                dish.title = menuItem.title
                dish.price = menuItem.price
                dish.image = menuItem.image
                dish.summary = menuItem.description
                dish.category = menuItem.category
                
            }
            try? viewContext.save()
        }
        catch {
            print(error)
        }
    }
}
