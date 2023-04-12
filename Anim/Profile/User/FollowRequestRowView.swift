//
//  FollowRequestRowView.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 4/11/23.
//

import SwiftUI

struct FollowRequestRowView: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    @State var user: User = User(uid: "", username: "", email: "", isPublic: false)
    
    @State var uid: String
    
    var body: some View {
        HStack {
            NavigationLink(destination: PublicProfile(selectedUser: user)) {
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
                }
                .padding([.leading])
            }
            
            Spacer()
            
            HStack {
                Button(action: {
                    FirestoreRequests().acceptFollowRequest(userID: userViewModel.user.uid!, requesterID: user.uid!)
                    userViewModel.user.followers?.append(user.uid!)
                    userViewModel.user.followRequests! = userViewModel.user.followRequests!.filter { $0 != user.uid!}
                }, label: {
                    Image(systemName: "checkmark")
                        .foregroundColor(.green)
                })
                Spacer()
                    .frame(width: 10)
                Button(action: {
                    FirestoreRequests().declineFollowRequest(userID: userViewModel.user.uid!, requesterID: user.uid!)
                    userViewModel.user.followRequests! = userViewModel.user.followRequests!.filter { $0 != user.uid!}
                }, label: {
                    Image(systemName: "xmark")
                        .foregroundColor(.red)
                })
            }
            Spacer()
                .frame(width: 10)
        }
        .padding()
        .onAppear {
            FirestoreRequests().getUser(uid) { data in
                user = data!
            }
        }
    }
    
}
