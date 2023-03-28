//
//  QuickStats.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 11/29/22.
//

import SwiftUI

struct UserView: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    @State var display: String
    
    var body: some View {
        if((userViewModel.user.username) != ""){
            Text(userViewModel.user.username!)
                .frame(alignment: .center)
                .font(Font.custom("DMSans-Medium", size: 30))
                .foregroundColor(Color("AnimGreen"))
        } else {
            Text("User")
                .frame(alignment: .center)
                .font(Font.custom("DMSans-Medium", size: 30))
                .foregroundColor(Color("AnimGreen"))
        }
        VStack(){
            Image(userViewModel.user.anim!)
                .resizable()
                .frame(width: 80, height: 80)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color("AnimGreen"), lineWidth: 3)
                )
            Spacer()
                .frame(height: 25)
            
            HStack{
                Button {
                    display = "info"
                } label: {
                    Text("Info")
                        .font(Font.custom("DMSans-Medium", size: 15))
                        .foregroundColor(Color("background"))
                        .lineLimit(1)
                        .padding()
                        .background(Color("AnimGreen"))
                        .cornerRadius(15)
                        .clipShape(Capsule())
                }
                Button {
                    display = "filter"
                } label: {
                    Text("Filter")
                        .font(Font.custom("DMSans-Medium", size: 15))
                        .foregroundColor(Color("background"))
                        .lineLimit(1)
                }
                .padding()
                .background(Color("AnimGreen"))
                .cornerRadius(15)
                .clipShape(Capsule())
                Button {
                    display = "nutrition"
                } label: {
                    Text("Nutrition")
                        .font(Font.custom("DMSans-Medium", size: 15))
                        .foregroundColor(Color("background"))
                        .lineLimit(1)
                }
                .padding()
                .background(Color("AnimGreen"))
                .cornerRadius(15)
                .clipShape(Capsule())
            }
            Spacer()
                .frame(height: 40)
            
            ScrollView(.vertical, showsIndicators: false) {
                if display == "filter" {
                    Section {
                        UserFilterModalView()
                    } header: {
                        Text("Filter & Sort")
                            .font(Font.custom("DMSans-Medium", size: 12))
                    }
                }
                else if display == "nutrition" {
                    FoodLogView()
                }
                else {
                    Button(){
                        
                    } label: {
                        if userViewModel.user.email != ""{
                            Text(userViewModel.user.email!)
                                .font(Font.custom("DMSans-Medium", size: 20))
                                .foregroundColor(Color("background"))
                                .lineLimit(1)
                        } else {
                            Text("No email shared")
                                .font(Font.custom("DMSans-Medium", size: 20))
                                .foregroundColor(Color("background"))
                                .lineLimit(1)
                        }
                    }
                    .padding()
                    .background(Color("AnimGreen"))
                    .cornerRadius(15)
                    .clipShape(Capsule())
                    Spacer()
                        .frame(height: 25)
                    Button(){
                        
                    } label: {
                        Text("Products Viewed: \(userViewModel.user.productsViewed!.count)")
                            .font(Font.custom("DMSans-Medium", size: 20))
                            .foregroundColor(Color("background"))
                            .lineLimit(1)
                    }
                    .padding()
                    .background(Color("AnimGreen"))
                    .cornerRadius(15)
                    .clipShape(Capsule())
                    Spacer()
                        .frame(height: 25)
                    Button(){
                        
                    } label: {
                        Text("Products Scanned: \(userViewModel.user.productsScanned!)")
                            .font(Font.custom("DMSans-Medium", size: 20))
                            .foregroundColor(Color("background"))
                            .lineLimit(1)
                    }
                    .padding()
                    .background(Color("AnimGreen"))
                    .cornerRadius(15)
                    .clipShape(Capsule())
                    Spacer()
                        .frame(height: 25)
                    Button(){
                        
                    } label: {
                        Text("Products Searched: \(userViewModel.user.productsFromSearch!)")
                            .font(Font.custom("DMSans-Medium", size: 20))
                            .foregroundColor(Color("background"))
                            .lineLimit(1)
                    }
                    .padding()
                    .background(Color("AnimGreen"))
                    .cornerRadius(15)
                    .clipShape(Capsule())
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
