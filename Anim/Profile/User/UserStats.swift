//
//  UserStats.swift
//  Anim
//
//  Created by Manovski on 4/6/23.
//

import SwiftUI

struct UserStats: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack {
                Spacer()
                VStack(){
                    Text("Products Searched")
                        .font(Font.custom("DMSans-Medium", size: 15))
                        .foregroundColor(Color("AnimGreen"))
                        .lineLimit(1)
                    Text("\(userViewModel.user.productsFromSearch!)")
                        .font(Font.custom("DMSans-Medium", size: 15))
                        .foregroundColor(Color("AnimGreen"))
                        .lineLimit(1)
                }
                Divider()
                Spacer()
                VStack(){
                    Text("Products Scanned")
                        .font(Font.custom("DMSans-Medium", size: 15))
                        .foregroundColor(Color("AnimGreen"))
                        .lineLimit(1)
                    Text("\(userViewModel.user.productsScanned!)")
                        .font(Font.custom("DMSans-Medium", size: 15))
                        .foregroundColor(Color("AnimGreen"))
                        .lineLimit(1)
                }
                Divider()
                Spacer()
                VStack(){
                    Text("Products Viewed")
                        .font(Font.custom("DMSans-Medium", size: 15))
                        .foregroundColor(Color("AnimGreen"))
                        .lineLimit(1)
                    Text("\(userViewModel.user.productsViewed!.count)")
                        .font(Font.custom("DMSans-Medium", size: 15))
                        .foregroundColor(Color("AnimGreen"))
                        .lineLimit(1)
                }
                Spacer()
            }
            .frame(height: 35)
        }
    }
}

struct UserStats_Previews: PreviewProvider {
    static var previews: some View {
        UserStats()
    }
}
