//
//  PostView.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 4/4/23.
//

import SwiftUI

struct PostView: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    @State var post: Post
    
    @Binding var togglePreview: Bool
    
    @State var postUser: User = User(uid: "", email: "")
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack {
                Text(postUser.username ?? "loading...")
                    .padding([.leading])
            }
            Divider()
            URLPreview(previewURL: URL(string: post.content!)!, togglePreview: $togglePreview)
                .padding()
            if userViewModel.state == .signedIn {
                HStack {
                    Button {
                        if (userViewModel.user.likedPosts?.contains(post.id!))! {
                            userViewModel.user.likedPosts! = userViewModel.user.likedPosts!.filter { $0 != post.id! }
                            FirestoreRequests().unLikePost(postID: post.id!, userID: userViewModel.user.uid!)
                        }
                        else {
                            userViewModel.user.likedPosts?.append(post.id!)
                            FirestoreRequests().likePost(postID: post.id!, userID: userViewModel.user.uid!)
                        }
                    } label: {
                        Image(systemName:  (userViewModel.user.likedPosts?.contains(post.id!))! ? "heart.fill" : "heart")
                            .foregroundColor( (userViewModel.user.likedPosts?.contains(post.id!))! ? .red : .gray)
                    }
                }
            }
            Text(post.caption!)
                .padding([.leading])
        }
        .onAppear {
            FirestoreRequests().getUser(post.userID!) { data in
                postUser = data!
            }
        }
    }
}

