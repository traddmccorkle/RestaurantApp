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
    @State private var startersShown = true
    @State private var mainsShown = true
    @State private var dessertsShown = true
    @State private var drinksShown = true
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                Image("Logo")
                    .padding(.bottom)
                
                VStack() {
                    HeroView()
                    
                    HStack {
                        Image(systemName: "magnifyingglass.circle.fill")
                            .resizable()
                            .foregroundColor(.accentWhite)
                            .frame(maxWidth: 33, maxHeight: 33)
                        TextField("Search the menu", text: $searchText)
                            .textFieldStyle(.roundedBorder)
                            .foregroundColor(.accentGreen)
                    }
                    .padding([.bottom, .leading, .trailing])
                }
                .background(Color.accentGreen)
                .padding(.bottom)
                
                HStack {
                    Toggle("Starters", isOn: $startersShown)
                    Toggle("Mains", isOn: $mainsShown)
                    Toggle("Desserts", isOn: $dessertsShown)
                    Toggle("Drinks", isOn: $drinksShown)
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .toggleStyle(littleLemonToggleStyle())
                .padding(.bottom)
                
                FetchedObjects(
                    predicate:buildPredicate(),
                    sortDescriptors: buildSortDescriptors()) {
                        (dishes: [Dish]) in
                        List {
                            ForEach(dishes, id:\.self) { dish in
                                NavigationLink(destination: ItemDetailsView(dish: dish)) {
                                    HStack {
                                        VStack(alignment: .leading) {
                                            Text(dish.title ?? "")
                                                .font(
                                                    .custom(
                                                        "Cochin",
                                                        fixedSize: 20)
                                                    .weight(.black)
                                                    
                                                )
                                            Text(dish.summary ?? "")
                                                .font(
                                                    .custom(
                                                        "Cochin",
                                                        fixedSize: 15)
                                                    
                                                )
                                                .lineLimit(2)
                                                .foregroundColor(.accentGreen)
                                            Text("$\(dish.price ?? "")")
                                                .font(
                                                    .custom(
                                                        "Cochin",
                                                        fixedSize: 20)
                                                    .weight(.black)
                                                    
                                                )
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
                        }
                        .listStyle(.plain)
                    }
            }
            .task {
                await reload(viewContext)
            }
        }
    }
    
    func buildPredicate() -> NSCompoundPredicate {
        let search = searchText == "" ? NSPredicate(value: true) : NSPredicate(format: "title CONTAINS[cd] %@", searchText)
        let starters = !startersShown ? NSPredicate(format: "category != %@", "starters") : NSPredicate(value: true)
        let mains = !mainsShown ? NSPredicate(format: "category != %@", "mains") : NSPredicate(value: true)
        let desserts = !dessertsShown ? NSPredicate(format: "category != %@", "desserts") : NSPredicate(value: true)
        let drinks = !drinksShown ? NSPredicate(format: "category != %@", "drinks") : NSPredicate(value: true)
        
        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [search, starters, mains, desserts, drinks])
        return compoundPredicate
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
