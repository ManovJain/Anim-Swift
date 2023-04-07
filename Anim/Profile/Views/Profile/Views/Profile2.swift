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
    @State var nutritionDisplay: String = "FoodLog"
    @State var followingPosts = [Post]()
    @State var showUsernameMissingAlert: Bool = false
    @State var allPosts = [Post]()
    @State var togglePreview = false
    @State var usernameSet = false
    
    var displays = ["Info", "Filter", "Nutrition"]
    
    var body: some View {
        VStack(){
            HStack{
                Image(userViewModel.user.anim!)
                    .resizable()
                    .frame(width: 50, height: 50)
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
                    Button("Filter", action: {display = "Filter"})
                        .buttonStyle(MenuButtonStyle())
                    Spacer()
                    Button("Nutrition", action: {display = "Nutrition"})
                        .buttonStyle(MenuButtonStyle())
                    Spacer()
                }
            }
            Spacer()
            ScrollView(.vertical, showsIndicators: false) {
                if display == "Filter" {
                    Section {
                        UserFilterModalView()
                    } header: {
                        Text("Filter & Sort")
                            .font(Font.custom("DMSans-Medium", size: 12))
                    }
                }
                else if display == "Nutrition" {
                    if nutritionDisplay == "FoodLog" {
                        Button("Input", action: {nutritionDisplay = "Input"})
                            .buttonStyle(MenuButtonStyle())
                        FoodLogView()
                    }
                    else {
                        Button("Food Log", action: {nutritionDisplay = "FoodLog"})
                            .buttonStyle(MenuButtonStyle())
                        FoodLogInputView()
                    }
                }
                else {
                    VStack {
                        ForEach(followingPosts, id: \.self) { post in
                            PostView(post: post, togglePreview: $togglePreview, missingUsername: $showUsernameMissingAlert)
                            Divider()
                        }
                    }
                    .background(GeometryReader {
                        return Color.clear.preference(key: ViewOffsetKey.self,
                                                      value: -$0.frame(in: .named("scroll")).origin.y)
                    })
                    .onAppear {
                        if userViewModel.state == .signedIn {
                            usernameSet = userViewModel.user.hasSetUsername!
                        }
                        if userViewModel.state == .signedIn {
                            FirestoreRequests().getFollowingPosts(following: [userViewModel.user.uid!]) { data in
                                followingPosts = data!.sorted{ $0.datePosted! > $1.datePosted!}
                            }
                        }
                    }
                    .padding(5)
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
