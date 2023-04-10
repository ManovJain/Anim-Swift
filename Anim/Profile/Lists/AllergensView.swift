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
    
    
    var allergensList = ["peanuts", "milk", "gluten", "soybeans", "eggs", "nuts", "fish"]
    
    var body: some View {
        VStack(){
            Text("Allergens coming soon")
                .frame(alignment: .center)
                .font(Font.custom("DMSans-Medium", size: 30))
                .foregroundColor(Color("AnimGreen"))
            //            Button {
            //                userViewModel.user.allergens!.removeAll()
            //            } label: {
            //                Text("Clear Selections")
            //                    .font(Font.custom("DMSans-Medium", size: 10))
            //                    .foregroundColor(Color("background"))
            //                    .lineLimit(1)
            //            }
            //            .padding()
            //            .background(.red)
            //            .cornerRadius(15)
            //            .clipShape(Capsule())
            VStack(alignment: .leading) {
                ScrollView(showsIndicators: false) {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(allergensList, id: \.self) { allergen in
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
