//
//  Onboarding.swift
//  RestaurantApp
//
//  Created by Tradd McCorkle on 12/11/23.
//

import SwiftUI

struct Onboarding: View {
    @State private var isLoggedIn = false
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    let kIsLoggedIn = "is logged in"
    let kFirstName = "first name key"
    let kLastName = "last name key"
    let kEmail = "email key"
    
    var body: some View {
        NavigationStack {
            VStack {
                NavigationLink(destination: Home(), isActive: $isLoggedIn) {
                    Home()
                }
                
                TextField("First Name", text: $firstName)
                TextField("Last Name", text: $lastName)
                TextField("E-mail Address", text: $email)
                
                Button(action: {
                    if !firstName.isEmpty && !lastName.isEmpty && !email.isEmpty {
                        // Additional check for a valid email
                        if isValidEmail(email) {
                            // Store data in UserDefaults
                            UserDefaults.standard.set(true, forKey: kIsLoggedIn)
                            UserDefaults.standard.set(firstName, forKey: kFirstName)
                            UserDefaults.standard.set(lastName, forKey: kLastName)
                            UserDefaults.standard.set(email, forKey: kEmail)
                            print("Stored first name:", UserDefaults.standard.string(forKey: kFirstName) ?? "nil")
                            print("Stored last name:", UserDefaults.standard.string(forKey: kLastName) ?? "nil")
                            print("Stored e-mail address:", UserDefaults.standard.string(forKey: kEmail) ?? "nil")
                            
                            isLoggedIn = true
                        } else {
                            // Handle invalid email
                            print("Invalid email address")
                        }
                    } else {
                        // Handle empty fields
                        print("Please fill in all fields")
                    }
                }, label: {
                    Text("Register")
                })
                // add an alert if any fields aren't handled correctly
            }
        }
        .onAppear {
            if UserDefaults.standard.bool(forKey: kIsLoggedIn) {
                isLoggedIn = true
                if isLoggedIn {
                    print("user is logged in")
                }
            }
        }
    }
    
    // Function to check if the email is valid
    private func isValidEmail(_ email: String) -> Bool {
        // Regular expression for a basic email format
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        // NSPredicate to evaluate the email format
        let emailPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        
        return emailPredicate.evaluate(with: email)
    }
}

#Preview {
    Onboarding()
}
