//
//  Profile2.swift
//  Anim
//
//  Created by Manovski on 4/5/23.
//

import SwiftUI

struct Profile2: View {
    @EnvironmentObject var userViewModel: UserViewModel
    
    @State var display: String
    @State var nutritionDisplay: String = "foodLog"
    
    var displays = ["Info", "Filter", "Nutrition"]
    
    var body: some View {
        VStack(){
            HStack{
                Image(userViewModel.user.anim!)
                    .resizable()
                    .frame(width: 60, height: 60)
                    .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color("AnimGreen"), lineWidth: 3)
                    )
                VStack{
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
                    HStack{
                        VStack {
                            Text("Posts")
                                .font(Font.custom("DMSans-Medium", size: 15))
                                .foregroundColor(Color("AnimGreen"))
                                .lineLimit(1)
                            Text("20")
                                .font(Font.custom("DMSans-Medium", size: 15))
                                .foregroundColor(Color("AnimGreen"))
                                .lineLimit(1)
                        }
                        Spacer()
                        VStack {
                            Text("Following")
                                .font(Font.custom("DMSans-Medium", size: 15))
                                .foregroundColor(Color("AnimGreen"))
                                .lineLimit(1)
                            Text("20")
                                .font(Font.custom("DMSans-Medium", size: 15))
                                .foregroundColor(Color("AnimGreen"))
                                .lineLimit(1)
                        }
                        Spacer()
                        VStack {
                            Text("Followers")
                                .font(Font.custom("DMSans-Medium", size: 15))
                                .foregroundColor(Color("AnimGreen"))
                                .lineLimit(1)
                            Text("20")
                                .font(Font.custom("DMSans-Medium", size: 15))
                                .foregroundColor(Color("AnimGreen"))
                                .lineLimit(1)
                        }
                        Spacer()
                    }
                }
                
            }
            Spacer()
                .frame(height: 20)
            UserStats()
            ScrollView(.horizontal){
                HStack(alignment: .center, spacing: 10){
                    Spacer()
                    Button("Info", action: {display = "info"})
                        .buttonStyle(MenuButtonStyle())
                        .buttonStyle(MenuButtonStyle())
                    Button("Filter", action: {display = "filter"})
                        .buttonStyle(MenuButtonStyle())
                    Button("Nutrition", action: {display = "nutrition"})
                        .buttonStyle(MenuButtonStyle())
                    Spacer()
                }
            }
            Spacer()
            
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
                    if nutritionDisplay == "foodLog" {
                        Button("Input", action: {nutritionDisplay = "input"})
                            .buttonStyle(MenuButtonStyle())
                        FoodLogView()
                    }
                    else {
                        Button("Food Log", action: {nutritionDisplay = "foodLog"})
                            .buttonStyle(MenuButtonStyle())
                        FoodLogInputView()
                    }
                }
                else {
                    Button(){
                        
                    } label: {
                        if userViewModel.user.email != ""{
                            Text(userViewModel.user.email!)
                                .font(Font.custom("DMSans-Medium", size: 15))
                                .foregroundColor(Color("background"))
                                .lineLimit(1)
                        } else {
                            Text("No email shared")
                                .font(Font.custom("DMSans-Medium", size: 15))
                                .foregroundColor(Color("background"))
                                .lineLimit(1)
                        }
                    }
                    .padding()
                    .background(Color("AnimGreen"))
                    .cornerRadius(15)
                    .clipShape(Capsule())
                    Spacer()
                        .frame(height: 20)
                    Button(){
                        
                    } label: {
                        Text("Products Viewed: \(userViewModel.user.productsViewed!.count)")
                            .font(Font.custom("DMSans-Medium", size: 15))
                            .foregroundColor(Color("background"))
                            .lineLimit(1)
                    }
                    .padding()
                    .background(Color("AnimGreen"))
                    .cornerRadius(15)
                    .clipShape(Capsule())
                    Spacer()
                        .frame(height: 20)
                    Button(){
                        
                    } label: {
                        Text("Products Scanned: \(userViewModel.user.productsScanned!)")
                            .font(Font.custom("DMSans-Medium", size: 15))
                            .foregroundColor(Color("background"))
                            .lineLimit(1)
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

struct MyFont {
    static let scrollStats = Font.custom("DMSans-Medium", size: 15.0)
}
