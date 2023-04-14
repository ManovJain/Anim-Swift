//
//  FollowerListItem.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 4/13/23.
//

import SwiftUI

struct FollowerListItem: View {
    
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    @State var user: User
    
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
                Button("Remove") {
                    if userViewModel.user.hasSetUsername! {
                        showAlert.toggle()
                    }
                }
                .padding([.trailing])
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
        }
        .padding()
        .alert(isPresented: $showAlert) {
            return Alert(title: Text("Remove \(user.username!)?"), message: Text("They will see that you have removed them."), primaryButton: .default(Text("Yes"))  {
                FirestoreRequests().removeFollower(userID: userViewModel.user.uid!, followerID: user.uid!)
                let userID = ["uid": user.uid!]
                userViewModel.user.followers! = userViewModel.user.followers!.filter {$0 != user.uid!}
                NotificationCenter.default.post(name: NSNotification.refreshFollowers, object: userID)
            } ,secondaryButton: .default(Text("No")) {})
        }
    }
}
