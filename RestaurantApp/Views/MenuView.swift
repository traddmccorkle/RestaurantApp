//
//  Menu.swift
//  RestaurantApp
//
//  Created by Tradd McCorkle on 12/11/23.
//

import SwiftUI
import CoreData

struct MenuView: View {
    @Environment(\.managedObjectContext) private var viewContext
    var persistence = PersistenceController()
    @State private var searchText: String = ""
    
    var body: some View {
        VStack {
            Image("Logo")
            
            Text("Chicago")
            
            FetchedObjects(
                predicate:buildPredicate(),
                sortDescriptors: buildSortDescriptors()) {
                (dishes: [Dish]) in
                List {
                    ForEach(dishes, id:\.self) { dish in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(dish.title ?? "")
                                Text(dish.summary ?? "")
                                    .font(.caption)
                                    .foregroundColor(.accentGreen)
                                Text("$\(dish.price ?? "")")
                                    .foregroundColor(.accentGreen)
                            }
                            Spacer()
                            if let imageUrl = URL(string: dish.image ?? "") {
                                AsyncImage(url: imageUrl) { image in
                                    image.resizable()
                                } placeholder: {
                                    Color.gray
                                }
                                .frame(width: 50, height: 50)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            }
                        }
                    }
                }
                .searchable(text: $searchText, prompt: "Search menu") // Search bar linked to searchText
            }
        }
        .task {
            await reload(viewContext)
        }
    }
    
    func buildPredicate() -> NSPredicate {
        let predicate: NSPredicate
        
        if searchText.isEmpty {
            print("searchText isEmpty")
            predicate = NSPredicate(value: true) // Return all entries if searchText is empty
        } else {
            print("searchText !isEmpty")
            predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        }
        
        return predicate
    }
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return   [NSSortDescriptor(key: "title",
                                   ascending: true,
                                   selector: #selector(NSString.localizedCompare))]
    }
    
    func reload(_ coreDataContext:NSManagedObjectContext) async {
        let url = URL(string: "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json")!
        let urlSession = URLSession.shared
        
        // Clears existing Dish data before fetching and storing new data
        persistence.clear()
        
        do {
            let (data, _) = try await urlSession.data(from: url)
            print("Attempting to decode JSON response...")
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
            
            // populate Core Data
//            Dish.deleteAll(coreDataContext)
//            Dish.createDishesFrom(menuItems:menuItems, coreDataContext)
        }
        catch { 
            print(error)
        }
    }
}

#Preview {
    MenuView()
}
