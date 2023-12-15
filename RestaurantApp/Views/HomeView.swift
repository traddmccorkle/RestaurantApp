//
//  Home.swift
//  RestaurantApp
//
//  Created by Tradd McCorkle on 12/11/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        TabView {
            MenuView()
                .tabItem {
                    Label("Menu", systemImage: "menucard" )
                }

            AccountView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle" )
                }
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    HomeView()
}
