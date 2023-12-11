//
//  Menu.swift
//  RestaurantApp
//
//  Created by Tradd McCorkle on 12/11/23.
//

import SwiftUI

struct Menu: View {
    @State private var location: String = ""
    
    var body: some View {
        VStack {
            Text("Little Lemon")
            Text("Location")
            Text("Description of application")
            
            List {
                //
            }
        }
    }
}

#Preview {
    Menu()
}
