//
//  Home.swift
//  RestaurantApp
//
//  Created by Tradd McCorkle on 12/11/23.
//

import SwiftUI

struct HomeView: View {
    let persistence = PersistenceController.shared
    
    var body: some View {
        TabView {
            MenuView(persistence: persistence)
                .environment(\.managedObjectContext, persistence.container.viewContext)
                .tabItem {
                    Label("Menu", systemImage: "menucard" )
                }
            
            AccountView()
                .tabItem {
                    Label("Account", systemImage: "person.crop.circle" )
                }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    HomeView()
}
