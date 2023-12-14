//
//  HeaderView.swift
//  RestaurantApp
//
//  Created by Tradd McCorkle on 12/13/23.
//

import SwiftUI

struct HeaderView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Image("Logo")
                NavigationLink(destination: UserProfileView()) {
                    Image("Profile")
                        .resizable()
                        .frame(maxWidth: 50, maxHeight: 50)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.trailing)
//                        .resizable()
//                        .aspectRatio( contentMode: .fit)
//                        .frame(maxHeight: 50)
//                        .clipShape(Circle())
//                        .padding(.trailing)
                }
            }
        }
    }
}

#Preview {
    HeaderView()
}
