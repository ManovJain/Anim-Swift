//
//  QuickStats.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 11/29/22.
//

import SwiftUI

struct User: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    var body: some View {
        if((userViewModel.userModel.username) != ""){
            Text(userViewModel.userModel.username!)
                .frame(alignment: .center)
                .font(.system(size: 30))
                .fontWeight(.bold)
        } else {
            Text("User")
                .frame(alignment: .center)
                .font(.system(size: 30))
                .fontWeight(.bold)
        }
        VStack(){
            Image(userViewModel.userModel.anim!)
                .resizable()
                .frame(width: 80, height: 80)
                .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(.green, lineWidth: 3)
                    )
            Spacer()
                .frame(height: 25)
            ScrollView(.vertical, showsIndicators: false) {
                Button(){
                    
                } label: {
                    if userViewModel.userModel.email != ""{
                        Text(userViewModel.userModel.email!)
                            .foregroundColor(.white)
                            .fontWeight(.heavy)
                            .lineLimit(1)
                    } else {
                        Text("No email shared")
                            .foregroundColor(.white)
                            .fontWeight(.heavy)
                            .lineLimit(1)
                    }
                }
                .padding()
                .background(.green)
                .cornerRadius(15)
                .clipShape(Capsule())
                Spacer()
                    .frame(height: 25)
                Button(){
                    
                } label: {
                    Text("Products Viewed: \(userViewModel.userModel.productsViewed!.count)")
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
                        .lineLimit(1)
                }
                .padding()
                .background(.green)
                .cornerRadius(15)
                .clipShape(Capsule())
                Spacer()
                    .frame(height: 25)
                Button(){
                    
                } label: {
                    Text("Products Scanned: \(userViewModel.userModel.productsScanned!)")
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
                        .lineLimit(1)
                }
                .padding()
                .background(.green)
                .cornerRadius(15)
                .clipShape(Capsule())
                Spacer()
                    .frame(height: 25)
                Button(){
                    
                } label: {
                    Text("Products Searched: \(userViewModel.userModel.productsFromSearch!)")
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
        .padding()
        .frame(
              minWidth: 0,
              maxWidth: .infinity,
              minHeight: 0,
              maxHeight: .infinity
            )
    }
}

struct User_Previews: PreviewProvider {
    static var previews: some View {
        User()
    }
}
