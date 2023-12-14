//
//  Styles.swift
//  RestaurantApp
//
//  Created by Tradd McCorkle on 12/14/23.
//

import SwiftUI

struct littleLemonToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        Button {
            configuration.isOn.toggle()
        } label: {
            HStack {
                configuration.label
            }
        }
        .foregroundColor(Color.accentBlack)
        .padding(5)
        .background {
            if configuration.isOn {
                Color.accentYellow
            }
        }
        .cornerRadius(8)
    }
}

extension Color {
    static let accentGreen = Color(#colorLiteral(red: 0.2862745225, green: 0.3686274588, blue: 0.3411764801, alpha: 1))
    static let accentYellow = Color(#colorLiteral(red: 0.9568627477, green: 0.8078432088, blue: 0.07843137532, alpha: 1))
    static let accentOrange = Color(#colorLiteral(red: 0.989240706, green: 0.5802358389, blue: 0.4141188264, alpha: 1))
    static let accentPeach = Color(#colorLiteral(red: 1, green: 0.8488721251, blue: 0.7164030075, alpha: 1))
    static let accentWhite = Color(#colorLiteral(red: 0.9276351333, green: 0.9375831485, blue: 0.9331009984, alpha: 1))
    static let accentBlack = Color(#colorLiteral(red: 0.1999999881, green: 0.1999999881, blue: 0.1999999881, alpha: 1))
}
