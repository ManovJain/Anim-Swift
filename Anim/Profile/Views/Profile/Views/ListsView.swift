//
//  ListsView.swift
//  Anim
//
//  Created by Manovski on 3/14/23.
//

import SwiftUI

struct ListsView: View {
    
    @State var selection: String
    var favorites = ["favorites", "fridge", "allergens"]
    
    var body: some View {
        HStack(){
            ForEach(favorites, id: \.self) { favorite in
                Button(favorite.capitalized, action: {selection = favorite})
                    .buttonStyle(MenuButtonStyle())
            }
        }
        Spacer()
        switch selection {
        case "favorites":
            Favorites()
        case "fridge":
            Fridge()
        case "allergens":
            AllergensView()
        default:
            Favorites()
        }
        
    }
}

