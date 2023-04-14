//
//  FollowingListItem.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 4/13/23.
//

import SwiftUI

struct FollowingListItem: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    @State var user: User
    
    @State var searchUserAlert: SearchUserAlert = .follow
    
    @State var showAlert: Bool = false
    
    var body: some View {
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
            if user.uid! != userViewModel.user.uid! {
                if userViewModel.user.following!.contains(user.uid!) {
                    Button("Unfollow") {
                        if userViewModel.user.hasSetUsername! {
                            searchUserAlert = .unfollow
                            showAlert.toggle()
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
                            searchUserAlert = .follow
                            showAlert.toggle()
                        }
                    }
                    .padding([.trailing])
                }
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .alert(isPresented: $showAlert) {
            switch searchUserAlert {
            case .follow:
                return Alert(title: Text("Follow \(user.username!)?"), message: Text("They will see that you are following them."), primaryButton: .default(Text("Yes"))  {
                    if user.isPublic! {
                        FirestoreRequests().followUser(posterID: user.uid!, followerID: userViewModel.user.uid!)
                        userViewModel.user.following?.append(user.uid!)
                        NotificationCenter.default.post(name: NSNotification.refreshFollowingPosts, object: nil)
                    }
                    else {
                        FirestoreRequests().followPrivateUser(posterID: user.uid!, followerID: userViewModel.user.uid!)
                        userViewModel.user.pendingRequests?.append(user.uid!)
                    }
                } ,secondaryButton: .default(Text("No")) {})
            case .unfollow:
                return Alert(title: Text("Unfollow \(user.username!)?"), message: Text("They will see that you are no longer following them."), primaryButton: .default(Text("Yes")){
                    userViewModel.user.following! = userViewModel.user.following!.filter {$0 != user.uid!}
                    FirestoreRequests().unFollowUser(posterID: user.uid!, followerID: userViewModel.user.uid!)
                    NotificationCenter.default.post(name: NSNotification.refreshFollowingPosts, object: nil)
                } ,secondaryButton: .default(Text("No")) {})
            }
        }
    }
}
