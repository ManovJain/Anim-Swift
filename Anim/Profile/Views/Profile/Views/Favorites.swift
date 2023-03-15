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
    
    var body: some View {
        Text("Favorites")
            .frame(alignment: .center)
            .font(Font.custom("DMSans-Medium", size: 30))
            .foregroundColor(Color("AnimGreen"))
        VStack(){
            VStack(alignment: .leading) {
                    ScrollView(showsIndicators: false) {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(userViewModel.user.favorites!, id: \.self) { favorite in
                                FavoritesButton(id: favorite)
                                
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
        .onAppear {
            print(userViewModel.user.fridgeItems)
        }
    }
}

struct Favorites_Previews: PreviewProvider {
    static var previews: some View {
        Favorites()
    }
}
