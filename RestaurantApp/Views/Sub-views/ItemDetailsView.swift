//
//  ItemDetailsView.swift
//  RestaurantApp
//
//  Created by Tradd McCorkle on 12/14/23.
//

import SwiftUI

struct ItemDetailsView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @ObservedObject var dish: Dish
    
    var body: some View {
        VStack {
            if let imageUrl = URL(string: dish.image ?? "") {
                AsyncImage(url: URL(string: dish.image ?? "")) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
                .clipShape(Rectangle())
                .frame(minHeight: 150)
            }
            
            VStack {
                Text(dish.title ?? "")
                    .font(
                        .custom(
                            "Cochin",
                            fixedSize: 35)
                        .weight(.black)
                        
                    )
                    .foregroundColor(.accentGreen)
                
                Text(dish.summary ?? "")
                    .font(
                        .custom(
                            "Cochin",
                            fixedSize: 25)
                        .weight(.black)
                        
                    )
                    .foregroundColor(.accentBlack)
                
                Text("$\(dish.price ?? "")")
                    .font(
                        .custom(
                            "Cochin",
                            fixedSize: 20)
                        .weight(.black)
                        
                    )
                    .foregroundColor(.accentGreen)
            }
            .padding([.leading, .trailing])
            
            Spacer()
        }
        .ignoresSafeArea()
    }
}

#Preview {
    ItemDetailsView(dish: PersistenceController.dishPreview())
}
