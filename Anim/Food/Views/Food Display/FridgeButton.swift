//
//  FridgeButton.swift
//  Anim
//
//  Created by Manovski on 4/10/23.
//

import SwiftUI

struct FridgeButton: View {
    @State var isFridgeOpen: Bool = false
    
    var body: some View {
        Button(action: {
            withAnimation {
                isFridgeOpen.toggle()
            }
        }) {
            Image(systemName: isFridgeOpen ? "fridge.fill" : "fridge")
                .font(.system(size: 50))
                .foregroundColor(Color.gray)
        }
        .rotation3DEffect(
            Angle.degrees(isFridgeOpen ? -45 : 0),
            axis: (x: 1.0, y: 0.0, z: 0.0)
        )
    }
}
