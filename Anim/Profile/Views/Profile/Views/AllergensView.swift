//
//  AllergensView.swift
//  Anim
//
//  Created by Manovski on 3/14/23.
//

import Foundation
import SwiftUI

struct AllergensView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var networkRequests: NetworkRequests
    
    @State var product: Product?
    @State var tagAlertShown = false
    @State var gradeAlertShown = false
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    
    var allergens = ["milk", "peanuts", "gluten"]
    
    var body: some View {
        Text("Favorites")
            .frame(alignment: .center)
            .font(Font.custom("DMSans-Medium", size: 30))
            .foregroundColor(Color("AnimGreen"))
        VStack(){
//            HStack(){
//                ForEach(favorites, id: \.self) { favorite in
//                    Button(){
//
//                    } label: {
//                        Text(favorite)
//                            .foregroundColor(.white)
//                            .fontWeight(.heavy)
//                            .lineLimit(1)
//                    }
//                    .padding()
//                    .background(.green)
//                    .cornerRadius(15)
//                    .clipShape(Capsule())
//                }
//            }
            VStack(alignment: .leading) {
                    ScrollView(showsIndicators: false) {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(allergens, id: \.self) { allergen in
                                AllergensViewButton(name: allergen, selected: false)
                                
                            }
                        }
                        .padding(10)
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


struct AllergensView_Previews: PreviewProvider {
    static var previews: some View {
        AllergensView()
    }
}
