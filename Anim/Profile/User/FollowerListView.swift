//
//  FollowerListView.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 4/13/23.
//

import SwiftUI

struct FollowerListView: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    @State var followers = [User]()
    
    @State var followerIDs: [String]
    
    @State var ownProfile: Bool
    
    var body: some View {
        ZStack {
            Color("background").edgesIgnoringSafeArea(.all)
            ScrollView {
                ForEach(followers, id: \.self) { user in
                    if user.uid! == userViewModel.user.uid! {
                        FollowingListItem(user: user)
                    }
                    else {
                        NavigationLink(destination: PublicProfile(selectedUser: user)) {
                            if ownProfile {
                                FollowerListItem(user: user)
                            }
                            else {
                                FollowingListItem(user: user)
                            }
                        }
                    }
                    Divider()
                }
            }
            .background(.clear)
        }
        .onAppear() {
            for id in followerIDs {
                FirestoreRequests().getUser(id) { data in
                    if followers.contains(data!) {
                        
                    }
                    else {
                        followers.append(data!)
                    }
                }
            }
        }
        
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.refreshFollowers)) { object in
            followers.removeAll()
//            let dict = object as! [AnyObject]
//            followerIDs = followerIDs.filter {$0 != object as String}
            for id in followerIDs {
                FirestoreRequests().getUser(id) { data in
                    if followers.contains(data!) {
                        
                    }
                    else {
                        followers.append(data!)
                    }
                }
            }
        }
    }
}
