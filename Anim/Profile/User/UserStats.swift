//
//  UserStats.swift
//  Anim
//
//  Created by Manovski on 4/6/23.
//

import SwiftUI

struct UserStats: View {
    
    @State var user: User
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack {
                Spacer()
                VStack(){
                    Text("Products Searched")
                        .font(Font.custom("DMSans-Medium", size: 15))
                        .foregroundColor(Color("AnimGreen"))
                        .lineLimit(1)
                    Text("\(user.productsFromSearch!)")
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
                    Text("\(user.productsScanned!)")
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
                    Text("\(user.productsViewed!.count)")
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
