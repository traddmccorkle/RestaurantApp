//
//  Home.swift
//  RestaurantApp
//
//  Created by Tradd McCorkle on 12/11/23.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        MenuView()
            .navigationBarBackButtonHidden()
    }
}

#Preview {
    HomeView()
}
