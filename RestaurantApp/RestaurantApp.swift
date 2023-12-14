//
//  RestaurantAppApp.swift
//  RestaurantApp
//
//  Created by Tradd McCorkle on 12/10/23.
//

import SwiftUI

@main
struct RestaurantApp: App {
    let persistence = PersistenceController.shared
    
    var body: some Scene {
        WindowGroup {
            OnboardingView()
        }
    }
}
