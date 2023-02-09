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
    @EnvironmentObject var networkRequests: NetworkRequests
    
    @State var product: Product?
    @State var tagAlertShown = false
    @State var gradeAlertShown = false
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    
    var favorites = ["saved", "liked", "disliked"]
    
    var body: some View {
        Text("Favorites")
            .frame(alignment: .center)
            .font(.system(size: 30))
            .fontWeight(.bold)
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
                    .clipShape(Capsule())
                }
            }
            VStack(alignment: .leading) {
                ScrollView{
                    ScrollView {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(userViewModel.userModel.favorites!, id: \.self) { favorite in
                                FavoritesButton(id: favorite)
                                
                            }
                        }
                    }
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
