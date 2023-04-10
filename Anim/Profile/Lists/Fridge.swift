//
//  Fridge.swift
//  Anim
//
//  Created by Manovski on 3/17/23.
//

import Foundation
import SwiftUI

struct Fridge: View {
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
        VStack(){
            Text("Fridge")
                .frame(alignment: .center)
                .font(Font.custom("DMSans-Medium", size: 30))
                .foregroundColor(Color("AnimGreen"))
            Button {
                userViewModel.user.fridgeItems?.removeAll()
            } label: {
                Text("Empty Fridge")
                    .font(Font.custom("DMSans-Medium", size: 10))
                    .foregroundColor(Color("background"))
                    .lineLimit(1)
            }
            .padding()
            .background(.red)
            .cornerRadius(15)
            .clipShape(Capsule())
            VStack(alignment: .leading) {
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(userViewModel.user.fridgeItems!, id: \.self) { fridge in
                            FavoritesButton(id: fridge)
                            
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

struct Fridge_Previews: PreviewProvider {
    static var previews: some View {
        Favorites()
    }
}
