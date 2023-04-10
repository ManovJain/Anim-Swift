//
//  SpinningStarButton.swift
//  Anim
//
//  Created by Manovski on 4/9/23.
//

import SwiftUI

struct SpinningStarButton: View {
    @State private var isPressed = false
    @State private var angle: Double = 0.0
    @State private var isTapped = false
    @State var favorited: Bool
    
    var body: some View {
        
        if favorited {
            Button(action: {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.5, blendDuration: 0.5)) {
                    self.isTapped.toggle()
                }
            }) {
                Image(systemName: "heart.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .foregroundColor(isTapped ? .gray : .pink)
                    .rotationEffect(.degrees(isTapped ? 0 : -360))
                    .scaleEffect(isTapped ? 1 : 1.5)
            }
        } else {
            Button(action: {
                withAnimation(.spring(response: 0.3, dampingFraction: 0.5, blendDuration: 0.5)) {
                    self.isTapped.toggle()
                }
            }) {
                Image(systemName: "heart.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .foregroundColor(isTapped ? .pink : .gray)
                    .rotationEffect(.degrees(isTapped ? -360 : 0))
                    .scaleEffect(isTapped ? 1.5 : 1)
            }
        }
    }
}
