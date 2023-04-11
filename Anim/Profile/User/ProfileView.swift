//
//  Profile2.swift
//  Anim
//
//  Created by Manovski on 4/5/23.
//

import SwiftUI

struct ProfileView: View {
    @EnvironmentObject var userViewModel: UserViewModel
    
    @State var display: String
    @State var nutritionDisplay: String = "FoodLog"
    @State var selfPosts = [Post]()
    @State var showUsernameMissingAlert: Bool = false
    @State var allPosts = [Post]()
    @State var togglePreview = false
    @State var usernameSet = false
    
    var displays = [
        ["displayName": "Posts", "image": "carrot.fill"],
        ["displayName": "Filter", "image": "checklist"],
        ["displayName": "Nutrition", "image": "heart.circle.fill"]
    ]
    
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
                    HStack{
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
//                        NavigationLink {
//                            CameraView() //figure out a better navigation link input
//                        } label: {
//                            Image(systemName: "bell")
//                                .font(.system(size: 30))
//                                .foregroundColor(Color("AnimGreen"))
//                        }
                    }
                    HStack{
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
            HStack(alignment: .center, spacing: 10){
                Spacer()
                if display == "Posts" {
                    VStack {
                        Button(action: {
                            display = "Posts"
                        }) {
                            Text("Posts")
                                .font(Font.custom("DMSans-Medium", size: 15))
                                .foregroundColor(Color("AnimGreen"))
                                .lineLimit(1)
                            Image(systemName: "carrot.fill")
                                .foregroundColor(Color("AnimGreen"))
                        }
                    }
                    .frame(height: 35)
                    .border(width: 2, edges: [.bottom], color: Color("AnimGreen"))
                } else {
                    Button(action: {
                        display = "Posts"
                    }) {
                        Text("Posts")
                            .font(Font.custom("DMSans-Medium", size: 15))
                            .foregroundColor(Color("AnimGreen"))
                            .lineLimit(1)
                        Image(systemName: "carrot.fill")
                            .foregroundColor(Color("AnimGreen"))
                    }
                }
                Spacer()
                if display == "Filter" {
                    VStack {
                        Button(action: {
                            display = "Filter"
                        }) {
                            Text("Filter")
                                .font(Font.custom("DMSans-Medium", size: 15))
                                .foregroundColor(Color("AnimGreen"))
                                .lineLimit(1)
                            Image(systemName: "checklist")
                                .foregroundColor(Color("AnimGreen"))
                        }
                    }
                    .frame(height: 35)
                    .border(width: 2, edges: [.bottom], color: Color("AnimGreen"))
                } else {
                    Button(action: {
                        display = "Filter"
                    }) {
                        Text("Filter")
                            .font(Font.custom("DMSans-Medium", size: 15))
                            .foregroundColor(Color("AnimGreen"))
                            .lineLimit(1)
                        Image(systemName: "checklist")
                            .foregroundColor(Color("AnimGreen"))
                    }
                }
                Spacer()
                if display == "Nutrition" {
                    VStack {
                        Button(action: {
                            display = "Nutrition"
                        }) {
                            Text("Nutrition")
                                .font(Font.custom("DMSans-Medium", size: 15))
                                .foregroundColor(Color("AnimGreen"))
                                .lineLimit(1)
                            Image(systemName: "heart.circle.fill")
                                .foregroundColor(Color("AnimGreen"))
                        }
                    }
                    .frame(height: 35)
                    .border(width: 2, edges: [.bottom], color: Color("AnimGreen"))
                } else {
                    Button(action: {
                        display = "Nutrition"
                    }) {
                        Text("Nutrition")
                            .font(Font.custom("DMSans-Medium", size: 15))
                            .foregroundColor(Color("AnimGreen"))
                            .lineLimit(1)
                        Image(systemName: "heart.circle.fill")
                            .foregroundColor(Color("AnimGreen"))
                    }
                }
                Spacer()
            }
            .frame(width: UIScreen.screenWidth,height: 50)
            .background(Color("background"))
            .border(width: 0.75, edges: [.top, .bottom], color: Color("AnimGreen"))
            .padding(.bottom)
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
                        ForEach(selfPosts, id: \.self) { post in
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
                                selfPosts = data!.sorted{ $0.datePosted! > $1.datePosted!}
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