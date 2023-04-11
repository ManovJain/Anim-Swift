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
                
                withAnimation(.spring()) {
                                self.isTapped.toggle()
                            }
            }) {
                Image(systemName: "heart.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: isTapped ? 50 : 30, height: isTapped ? 50 : 30)
                    .foregroundColor(isTapped ? .gray : .pink)
                    .rotationEffect(.degrees(isTapped ? 0 : 360))
            }
        } else {
            Button(action: {
                
                userViewModel.user.favorites?.append(id)
                
                withAnimation(.spring()) {
                                self.isTapped.toggle()
                            }
                
            }) {
                Image(systemName: "heart.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: isTapped ? 50 : 30, height: isTapped ? 50 : 30)
                    .foregroundColor(isTapped ? .pink : .gray)
                    .rotationEffect(.degrees(isTapped ? 360 : 0))
            }
        }
    }
}