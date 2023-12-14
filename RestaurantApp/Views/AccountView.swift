//
//  UserProfile.swift
//  RestaurantApp
//
//  Created by Tradd McCorkle on 12/11/23.
//

import SwiftUI

struct AccountView: View {
    @State private var firstName = UserDefaults.standard.string(forKey: "first name key") ?? "First Name"
    @State private var lastName = UserDefaults.standard.string(forKey: "last name key") ?? "Last Name"
    @State private var email = UserDefaults.standard.string(forKey: "email key") ?? "E-mail Address"
    let kIsLoggedIn = "is logged in"
    let kFirstName = "first name key"
    let kLastName = "last name key"
    let kEmail = "email key"
    
    @Environment(\.presentationMode) var presentation
    
    var body: some View {
        VStack {
            Image("Logo")
            VStack {
                Text("Account Information")
                    .font(
                        .custom(
                            "Cochin",
                            fixedSize: 30)
                        .weight(.black)
                        
                    )
                
                Image(systemName: "person.crop.circle")
                    .resizable()
                    .foregroundColor(.accentGreen)
                    .frame(maxWidth: 100, maxHeight: 100)
                
                VStack {
                    Text("First Name *")
                        .font(.caption)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextField(firstName, text: $firstName)
                        .onChange(of: firstName) {
                            print("Stored first name:", UserDefaults.standard.string(forKey: kFirstName) ?? "nil")
                            UserDefaults.standard.set(firstName, forKey: kFirstName)
                        }
                    Text("Last Name *")
                        .font(.caption)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextField(lastName, text: $lastName)
                        .onChange(of: lastName) {
                            print("Stored last name:", UserDefaults.standard.string(forKey: kLastName) ?? "nil")
                            UserDefaults.standard.set(lastName, forKey: kLastName)
                        }
                    Text("E-mail Address *")
                        .font(.caption)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    TextField(email, text: $email)
                        .onChange(of: email) {
                            if isValidEmail(email) {
                                UserDefaults.standard.set(email, forKey: kEmail)
                                print("Stored e-mail address:", UserDefaults.standard.string(forKey: kEmail) ?? "nil")
                            } else {
                                // Handle invalid email
                                print("Invalid email address")
                            }
                        }
                }
                .foregroundColor(.secondary)
                .frame(maxWidth: 350)
                .textFieldStyle(.roundedBorder)
                
            }
            
            Button(action: {
                UserDefaults.standard.set(false, forKey: "is logged in")
                self.presentation.wrappedValue.dismiss()
            }, label: {
                Text("Logout")
                    .foregroundColor(.accentBlack)
            })
            .padding(.top)
            .tint(.accentYellow)
            .buttonStyle(.borderedProminent)
            
            Spacer()
        }
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        // Regular expression for a basic email format
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        // NSPredicate to evaluate the email format
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        return emailPredicate.evaluate(with: email)
    }
}

#Preview {
    AccountView()
}
