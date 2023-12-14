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
                        .font(
                            .custom(
                                "Cochin",
                                fixedSize: 35)
                            .weight(.black)
                            
                        )
                        .foregroundColor(.accentYellow)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.top)
                    Text("Chicago")
                        .font(
                            .custom(
                                "Cochin",
                                fixedSize: 25)
                            .weight(.black)
                            
                        )
                        .foregroundColor(.accentWhite)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        Spacer()
                    Text("We are a family owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                        .font(
                            .custom(
                                "Cochin",
                                fixedSize: 16)
                            
                        )
                        .foregroundColor(.accentWhite)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom)
                    Spacer()
                }
                .padding(.leading)
                Image("Hero image")
                    .resizable()
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .frame(width: 125, height: 125)
                    .padding(.trailing)
            }
            .frame(maxWidth: .infinity, maxHeight: 220)
            .background(Color.accentGreen)
        }
    }
}

#Preview {
    HeroView()
}
