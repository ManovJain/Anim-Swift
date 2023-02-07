//
//  Favorites.swift
//  Anim
//
//  Created by Manovski on 12/16/22.
//

import Foundation
import SwiftUI

struct Favorites: View {
    @EnvironmentObject var userViewModel: UserViewModel
    
    var favorites = ["saved", "liked", "disliked"]
    var body: some View {
        VStack(){
            HStack(){
                ForEach(favorites, id: \.self) { favorite in
                    Button(){
                        
                    } label: {
                        Text(favorite)
                            .foregroundColor(.white)
                            .fontWeight(.heavy)
                            .lineLimit(1)
                    }
                    .padding()
                    .background(.green)
                    .cornerRadius(15)
                    .clipShape(Capsule())            }
            }
            VStack(alignment: .leading) {
                ScrollView{
                    ForEach(userViewModel.userModel.favorites!, id: \.self) { favorite in
                        Button() {
                            print("Button tapped!")
                        } label: {
                            HStack{
                                Image(systemName: "bird")
                                    .foregroundColor(.indigo)
                                Text(favorite)
                                    .foregroundColor(.indigo)
                                Spacer()

                                Text("A")
                                    .font(.caption)
                                    .padding(10)
                                    .background(.green)
                                    .clipShape(Circle())
                                    .foregroundColor(.primary)
                                Spacer()
                            }
                            .padding()
                            .overlay(
                                RoundedRectangle(cornerRadius: 4)
                                    .stroke(.indigo, lineWidth: 4)
                            )
                        }
                    }
//                    ForEach((1...10).reversed(), id: \.self) {_ in
//                    }
                }
            }
        }
        .padding()
        .frame(
              minWidth: 0,
              maxWidth: .infinity,
              minHeight: 0,
              maxHeight: .infinity
            )
    }
}

struct Favorites_Previews: PreviewProvider {
    static var previews: some View {
        Favorites()
    }
}
