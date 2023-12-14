//
//  FoodItemView.swift
//  RestaurantApp
//
//  Created by Tradd McCorkle on 12/14/23.
//

import SwiftUI

struct FoodItemView: View {
    @ObservedObject var dish: Dish
    
    var body: some View {
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

#Preview {
    FoodItemView(dish: PersistenceController.dishPreview())
}
