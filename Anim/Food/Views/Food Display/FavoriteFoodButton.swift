//
//  SpinningStarButton.swift
//  Anim
//
//  Created by Manovski on 4/9/23.
//

import SwiftUI

struct FavoriteFoodButton: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    @State private var isPressed = false
    @State private var angle: Double = 0.0
    @State private var isTapped = false
    @State var favorited: Bool
    @State var id: String
    
    var body: some View {
        
        if favorited {
            Button(action: {
                userViewModel.user.favorites = userViewModel.user.favorites?.filter { $0 != (id) }
                withAnimation(.easeInOut(duration: 1.0)) {
                    isTapped.toggle()
                }
            }) {
                Image(systemName: "heart.fill")
                    .foregroundColor(isTapped ? Color.red : Color.gray)
                    .font(.system(size: 30))
            }
            .rotationEffect(Angle.degrees(isTapped ? 360 : 0))
        } else {
            Button(action: {
                
                userViewModel.user.favorites?.append(id)
                
                withAnimation(.easeInOut(duration: 1.0)) {
                    isTapped.toggle()
                }
                
            }) {
                Image(systemName: "heart.fill")
                    .foregroundColor(isTapped ? Color.gray : Color.red)
                    .font(.system(size: 30))
            }
            .rotationEffect(Angle.degrees(isTapped ? 0 : 360))
        }
    }
}
