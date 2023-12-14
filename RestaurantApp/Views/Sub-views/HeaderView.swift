//
//  HeaderView.swift
//  RestaurantApp
//
//  Created by Tradd McCorkle on 12/14/23.
//

import SwiftUI

struct HeaderView: View {
    @State private var isLoggedIn = false
    
    var body: some View {
        NavigationStack {
            VStack {
                ZStack {
                    Image("Logo")
                    if(isLoggedIn) {
                        NavigationLink(destination: AccountView()) {
                            HStack {
                                Spacer()
                                Image(systemName: "person.crop.circle")
                                    .resizable()
                                    .aspectRatio( contentMode: .fit)
                                    .frame(maxHeight: 50)
                                    .padding(.trailing)
                                    .foregroundColor(.accentGreen)
                            }
                        }
                    }
                }
            }
        }
        .frame(maxHeight: 50)
        .onAppear() {
            if UserDefaults.standard.bool(forKey: "is logged in") {
                isLoggedIn = true
            } else {
                isLoggedIn = false
            }
        }
    }
}

#Preview {
    HeaderView()
}
