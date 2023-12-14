//
//  Menu.swift
//  RestaurantApp
//
//  Created by Tradd McCorkle on 12/11/23.
//

import SwiftUI

struct MenuView: View {
    @Environment(\.managedObjectContext) private var viewContext
    var persistence = PersistenceController()
    @State private var location: String = ""
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
                            if let imageUrl = URL(string: dish.image ?? "") {
                                AsyncImage(url: imageUrl) { image in
                                    image.resizable()
                                } placeholder: {
                                    Color.gray
                                }
                                .frame(width: 50, height: 50)
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            }
                            Text(dish.title ?? "")
                            Spacer()
                            Text("$\(dish.price ?? "")")
                        }
                    }
                }
                .searchable(text: $searchText, prompt: "Search menu") // Search bar linked to searchText
            }
        }
        .onAppear(perform: {
            print("fetching menu data")
            getMenuData()
        })
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
    
//    func reload(_ coreDataContext:NSManagedObjectContext) async {
//        let url = URL(string: "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json")!
//        let urlSession = URLSession.shared
//        
//        do {
//            let (data, _) = try await urlSession.data(from: url)
//            let fullMenu = try JSONDecoder().decode(MenuList.self, from: data)
//            let menuItems = fullMenu.menu
//        }
//        catch { }
//    }
    
    func getMenuData() {
        let urlString = "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main/menu.json"
        let url = URL(string: urlString)!
        let request = URLRequest(url: url)
        
        // Clears existing Dish data before fetching and storing new data
        persistence.clear()
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
                print("Server error with status code: \(httpResponse.statusCode)")
                return
            }
            if let data = data {
                let JSONDecoder = JSONDecoder()
                if let menuItems = try? JSONDecoder.decode(MenuList.self, from: data) {
                    print("data received")
                    DispatchQueue.main.async {
                        menuItems.menu.forEach { menuItem in
                            let dish = Dish(context: viewContext)
                            dish.title = menuItem.title
                            dish.price = menuItem.price
                            dish.image = menuItem.image
                        }
                        try? viewContext.save()
                    }
                }
            }
        }
        
        task.resume()
    }
}

#Preview {
    MenuView()
}
