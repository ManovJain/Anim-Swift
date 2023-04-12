//
//  SearchUserPage.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 4/6/23.
//

import SwiftUI

enum SearchUserAlert {
    case follow
    case unfollow
}

struct SearchUserPage: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    @State var users = [User]()
    
    @State var selectedUser: User = User(uid: "", username: "", email: "", isPublic: false)
    
    @State var searchText = ""
    
    @Binding var missingUsername : Bool
    
    @State var searchUserAlert: SearchUserAlert = .follow
    
    @State var showAlert: Bool = false
    
    var body: some View {
        ZStack {
            Color("background").edgesIgnoringSafeArea(.all)
            VStack {
                HStack {
                    Image(systemName: "magnifyingglass").foregroundColor(.gray)
                    TextField("Search", text: $searchText)
                        .font(Font.system(size: 21))
                        .textInputAutocapitalization(.none)
                }
                .padding(7)
                .background(Color("searchBarColor"))
                .cornerRadius(50)
                Divider().background(Color.gray)
                    .padding(.top, 10)
                ScrollView {
                    ForEach(users, id: \.self) { user in
                        NavigationLink(destination: PublicProfile(selectedUser: user)) {
                            HStack {
                                
                                Image(user.anim ?? "animLogoIcon")
                                    .resizable()
                                    .frame(width: 30, height: 30, alignment: .leading)
                                    .padding(5)
                                    .overlay(
                                        Circle()
                                            .stroke(.primary, lineWidth: 2)
                                            .foregroundColor(.primary)
                                    )
                                VStack (alignment: .leading) {
                                    Text(user.username!)
                                        .foregroundColor(.primary)
                                    Text("\((user.followers?.count)!) \(user.followers?.count == 1 ? "follower" : "followers")")
                                        .foregroundColor(.gray)
                                }
                                .padding([.leading])
                                Spacer()
                                if userViewModel.user.following!.contains(user.uid!) {
                                    Button("Unfollow") {
                                        if userViewModel.user.hasSetUsername! {
                                            selectedUser = user
                                            searchUserAlert = .unfollow
                                            showAlert.toggle()
                                        }
                                        else {
                                            missingUsername.toggle()
                                        }
                                    }
                                    .padding([.trailing])
                                }
                                else if userViewModel.user.pendingRequests!.contains(user.uid!) {
                                    Text("Requested")
                                        .foregroundColor(.gray)
                                }
                                else {
                                    Button("Follow") {
                                        if userViewModel.user.hasSetUsername! {
                                            selectedUser = user
                                            searchUserAlert = .follow
                                            showAlert.toggle()
                                        }
                                        else {
                                            missingUsername.toggle()
                                        }
                                    }
                                    .padding([.trailing])
                                }
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.gray)
                            }
                            .padding()
                        }
                        Divider()
                    }
                }
                .background(.clear)
            }
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
        .onChange(of: searchText) { value in
            FirestoreRequests().getUserSearch(searchTerm: searchText, userUsername: userViewModel.user.username!) { data in
                users = data!.sorted {$0.followers!.count > $1.followers!.count}
            }
        }
    }
}
