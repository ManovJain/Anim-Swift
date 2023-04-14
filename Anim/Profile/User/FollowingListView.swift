//
//  FollowingListView.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 4/13/23.
//

import SwiftUI

struct FollowingListView: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    @State var following = [User]()
    
    @State var followingIDs: [String]
    
    var body: some View {
        ZStack {
            Color("background").edgesIgnoringSafeArea(.all)
            ScrollView {
                ForEach(following, id: \.self) { user in
                    if user.uid! == userViewModel.user.uid! {
                        FollowingListItem(user: user)
                    }
                    else {
                        NavigationLink(destination: PublicProfile(selectedUser: user)) {
                            FollowingListItem(user: user)
                        }
                    }
                    Divider()
                }
            }
            .background(.clear)
        }
        .onAppear() {
            for id in followingIDs {
                FirestoreRequests().getUser(id) { data in
                    if following.contains(data!) {
                        
                    }
                    else {
                        following.append(data!)
                    }
                }
            }
        }
    }
}
