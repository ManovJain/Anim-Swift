//
//  MenuButtonStyle.swift
//  Anim
//
//  Created by Manovski on 4/10/23.
//

import SwiftUI

struct MenuButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(Font.custom("DMSans-Medium", size: 15))
            .foregroundColor(Color("background"))
            .lineLimit(1)
            .padding()
            .frame(height: 40)
            .frame(minWidth: 80, maxWidth: .infinity)
            .background(configuration.isPressed ? Color("background") : Color("AnimGreen"))
            .clipShape(Capsule())
            .cornerRadius(15)
            .scaleEffect(configuration.isPressed ? 0.8 : 1.0)
    }
}
