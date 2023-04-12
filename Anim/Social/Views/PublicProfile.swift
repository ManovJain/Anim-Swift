//
//  PublicProfile.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 4/11/23.
//

import SwiftUI

struct PublicProfile: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    @State var userPosts = [Post]()
    @State var showUsernameMissingAlert: Bool = false
    @State var togglePreview = false
    @State var selectedUser: User
    @State var searchUserAlert: SearchUserAlert = .follow
    
    @State var showAlert: Bool = false
    
    var body: some View {
        ZStack {
            Color("background").edgesIgnoringSafeArea(.all)
            VStack(){
                HStack (alignment: .center){
                    Image(selectedUser.anim!)
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color("AnimGreen"), lineWidth: 3)
                        )
                    VStack (alignment: .leading){
                        HStack{
                            Spacer()
                            VStack {
                                Text("Following")
                                    .font(Font.custom("DMSans-Medium", size: 15))
                                    .foregroundColor(Color("AnimGreen"))
                                    .lineLimit(1)
                                Text("\(selectedUser.following!.count)")
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
                                Text("\(selectedUser.followers!.count)")
                                    .font(Font.custom("DMSans-Medium", size: 15))
                                    .foregroundColor(Color("AnimGreen"))
                                    .lineLimit(1)
                            }
                            Spacer()
                        }
                    }
                }
                Spacer()
                    .frame(height: 10)
                
                if userViewModel.user.following!.contains(selectedUser.uid!) {
                    Button(action: {
                        if userViewModel.user.hasSetUsername! {
                            searchUserAlert = .unfollow
                            showAlert.toggle()
                        }
                    }, label: {
                        VStack {
                            Text("Unfollow")
                                .font(Font.custom("DMSans-Medium", size: 17))
                                .frame(width: UIScreen.screenWidth - 40)
                                .foregroundColor(.white)
                                .padding(4)
                        }
                        .background(.blue)
                        .clipShape(
                            RoundedRectangle(
                                cornerRadius: 8
                            )
                        )
                    })
                }
                else if userViewModel.user.pendingRequests!.contains(selectedUser.uid!) {
                    VStack {
                        Text("Requested")
                            .font(Font.custom("DMSans-Medium", size: 17))
                            .frame(width: UIScreen.screenWidth - 40)
                            .foregroundColor(.white)
                            .padding(4)
                    }
                    .background(.gray)
                    .clipShape(
                        RoundedRectangle(
                            cornerRadius: 8
                        )
                    )
                }
                else {
                    Button(action: {
                        if userViewModel.user.hasSetUsername! {
                            searchUserAlert = .follow
                            showAlert.toggle()
                        }
                    }, label: {
                        VStack {
                            Text("Follow")
                                .font(Font.custom("DMSans-Medium", size: 17))
                                .frame(width: UIScreen.screenWidth - 40)
                                .foregroundColor(.white)
                                .padding(4)
                        }
                        .background(.blue)
                        .clipShape(
                            RoundedRectangle(
                                cornerRadius: 8
                            )
                        )
                    })
                }
                UserStats()
                    .blur(radius: selectedUser.isPublic! ? 0 : 10)
                Divider()
                ScrollView(.vertical, showsIndicators: false) {
                    if selectedUser.isPublic! {
                        VStack {
                            ForEach(userPosts, id: \.self) { post in
                                PostView(post: post, togglePreview: $togglePreview, missingUsername: $showUsernameMissingAlert)
                                Divider()
                            }
                        }
                        .background(GeometryReader {
                            return Color.clear.preference(key: ViewOffsetKey.self,
                                                          value: -$0.frame(in: .named("scroll")).origin.y)
                        })
                        .onAppear {
                            FirestoreRequests().getFollowingPosts(following: [selectedUser.uid!]) { data in
                                userPosts = data!.sorted{ $0.datePosted! > $1.datePosted!}
                            }
                        }
                        .padding(5)
                    }
                    else {
                        VStack {
                            Text("This account is private.")
                                .bold()
                            Text("Follow to see their posts.")
                        }
                    }
                }
                .navigationTitle(selectedUser.username!)
                .alert(isPresented: $showAlert) {
                    switch searchUserAlert {
                    case .follow:
                        return Alert(title: Text("Follow \(selectedUser.username!)?"), message: Text("They will see that you are following them."), primaryButton: .default(Text("Yes"))  {
                            if selectedUser.isPublic! {
                                FirestoreRequests().followUser(posterID: selectedUser.uid!, followerID: userViewModel.user.uid!)
                                userViewModel.user.following?.append(selectedUser.uid!)
                                NotificationCenter.default.post(name: NSNotification.refreshFollowingPosts, object: nil)
                            }
                            else {
                                FirestoreRequests().followPrivateUser(posterID: selectedUser.uid!, followerID: userViewModel.user.uid!)
                                userViewModel.user.pendingRequests?.append(selectedUser.uid!)
                            }
                        } ,secondaryButton: .default(Text("No")) {})
                    case .unfollow:
                        return Alert(title: Text("Unfollow \(selectedUser.username!)?"), message: Text("They will see that you are no longer following them."), primaryButton: .default(Text("Yes")){
                            userViewModel.user.following! = userViewModel.user.following!.filter {$0 != selectedUser.uid!}
                            FirestoreRequests().unFollowUser(posterID: selectedUser.uid!, followerID: userViewModel.user.uid!)
                            NotificationCenter.default.post(name: NSNotification.refreshFollowingPosts, object: nil)
                        } ,secondaryButton: .default(Text("No")) {})
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
}
