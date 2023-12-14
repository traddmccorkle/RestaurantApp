//
//  HeroView.swift
//  RestaurantApp
//
//  Created by Tradd McCorkle on 12/13/23.
//

import SwiftUI

struct HeroView: View {
    var body: some View {
        VStack {
            HStack {
                VStack {
                    Text("Litttle Lemon")
                        .font(.largeTitle)
                        .foregroundColor(.accentYellow)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    Text("Chicago")
                        .font(.title)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 5)
                    Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.leading)
                Image("Hero image")
                    .resizable()
                    .cornerRadius(10)
                    .padding(.trailing)
                    .frame(maxWidth:125, maxHeight:125)
            }
            .frame(maxWidth: .infinity, maxHeight: 200)
            .background(Color.accentGreen)
            .padding(.bottom)
        }
    }
}

#Preview {
    HeroView()
}
