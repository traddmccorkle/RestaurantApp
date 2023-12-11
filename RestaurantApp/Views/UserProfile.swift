//
//  UserProfile.swift
//  RestaurantApp
//
//  Created by Tradd McCorkle on 12/11/23.
//

import SwiftUI

struct UserProfile: View {
    let firstName = UserDefaults.standard.string(forKey: "first name key") ?? "First Name"
    let lastName = UserDefaults.standard.string(forKey: "last name key") ?? "Last Name"
    let email = UserDefaults.standard.string(forKey: "email key") ?? "E-mail Address"
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack {
            Text("Personal Information")
            Image("profile-image-placeholder")
                .resizable()
                .frame(maxWidth: 50, maxHeight: 50)
            
            Text(firstName)
            Text(lastName)
            Text(email)
            
            Button(action: {
                UserDefaults.standard.set(false, forKey: "is logged in")
                self.presentation.wrappedValue.dismiss()
            }, label: {
                Text("Logout")
            })
            
            Spacer()
        }
    }
}

#Preview {
    UserProfile()
}
