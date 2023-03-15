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
                Button(){
                    selection = favorite
                } label: {
                    Text(favorite)
                        .font(Font.custom("DMSans-Medium", size: 12))
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
                        .lineLimit(1)
                }
                .padding()
                .background(Color("AnimGreen"))
                .cornerRadius(15)
                .clipShape(Capsule())
            }
        }
        Spacer()
        switch selection {
        case "favorites":
            Favorites()
        case "fridge":
            Text("FRIDGE")
        case "allergens":
                AllergensView()
        default:
            Favorites()
        }
        
    }
}

//struct ListsView_Previews: PreviewProvider {
//    static var previews: some View {
//        ListsView()
//    }
//}
