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
    @State var nutritionDisplay: String = "foodLog"
    
    var displays = ["Info", "Filter", "Nutrition"]
    
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
                .frame(width: 60, height: 60)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color("AnimGreen"), lineWidth: 3)
                )
            Spacer()
                .frame(height: 25)
            
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
                    .padding()
                    .background(Color("AnimGreen"))
                    .cornerRadius(15)
                    .clipShape(Capsule())
                    Spacer()
                        .frame(height: 20)
                    Button(){
                        
                    } label: {
                        Text("Products Searched: \(userViewModel.user.productsFromSearch!)")
                            .font(Font.custom("DMSans-Medium", size: 15))
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

struct MenuButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(Font.custom("DMSans-Medium", size: 15))
            .foregroundColor(Color("background"))
            .lineLimit(1)
            .padding()
            .frame(height: 40)
            .frame(minWidth: 80, maxWidth: .infinity)
            .background(configuration.isPressed ? Color("background") : Color("AnimGreen"))
            .clipShape(Capsule())
            .cornerRadius(15)
            .scaleEffect(configuration.isPressed ? 0.8 : 1.0)
    }
}

