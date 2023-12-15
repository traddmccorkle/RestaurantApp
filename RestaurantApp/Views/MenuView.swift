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
    
    @State private var searchText: String = ""
    @State private var startersShown = true
    @State private var mainsShown = true
    @State private var dessertsShown = true
    @State private var drinksShown = true
    @State private var menuItemsLoaded = false
    
    var body: some View {
        NavigationStack() {
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
                        List(dishes) { dish in
                            NavigationLink(destination: ItemDetailsView(dish: dish)) {
                                FoodItemView(dish: dish)
                            }
                        }
                        .listStyle(.plain)
                    }
            }
            .navigationBarBackButtonHidden()
            .task {
                // temporary fix for duplicate menu items appearing on refresh
                if !menuItemsLoaded {
                    await MenuList.getMenuData(viewContext: viewContext)
                    menuItemsLoaded = true
                }
            }
        }
    }
    
    func buildSortDescriptors() -> [NSSortDescriptor] {
        return   [NSSortDescriptor(key: "title",
                                   ascending: true,
                                   selector: #selector(NSString.localizedCompare))]
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
}

#Preview {
    MenuView()
}
