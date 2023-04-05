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
    
    @State var numLikes = 0
    
    @State var comments = [Comment]()
    
    @State var comment: String = ""
    
    var body: some View {
        VStack (alignment: .leading) {
            HStack (spacing: 0.1) {
                Image(postUser.anim ?? "animLogoIcon")
                    .resizable()
                    .frame(width: 30, height: 30, alignment: .leading)
                    .padding(5)
                    .overlay(
                        Circle()
                            .stroke(.primary, lineWidth: 2)
                    )
                Text(post.username!)
                    .padding([.leading])
                    .fontWeight(.bold)
            }
            .padding(.top, 1)
            .padding([.leading])
            URLPreview(previewURL: URL(string: post.content!)!, togglePreview: $togglePreview)
                .padding([.horizontal], 4)
            //MARK: Like Button and Like Count
            HStack {
                if userViewModel.state == .signedIn {
                    Button {
                        if (userViewModel.user.likedPosts?.contains(post.id!))! {
                            userViewModel.user.likedPosts! = userViewModel.user.likedPosts!.filter { $0 != post.id! }
                            FirestoreRequests().unLikePost(postID: post.id!, userID: userViewModel.user.uid!)
                            numLikes -= 1
                        }
                        else {
                            userViewModel.user.likedPosts?.append(post.id!)
                            FirestoreRequests().likePost(postID: post.id!, userID: userViewModel.user.uid!)
                            numLikes += 1
                        }
                    } label: {
                        Image(systemName:  (userViewModel.user.likedPosts?.contains(post.id!))! ? "heart.fill" : "heart")
                            .foregroundColor( (userViewModel.user.likedPosts?.contains(post.id!))! ? .red : .gray)
                    }
                }
                
                Text("\(numLikes) \(numLikes == 1 ? "like" : "likes")")
                    .bold()
            }
            .padding([.horizontal])
            .padding([.bottom], 4)
            //MARK: Caption
            HStack {
                Text(post.username!).bold() +
                Text("")
                Text(post.caption!)
            }
            .padding([.leading])
            .padding([.bottom], 3)
            //MARK: Comments
            if comments.count > 2 {
                Text("View all comments")
                    .foregroundColor(.gray)
                    .padding([.leading])
                    .padding([.bottom], 3)
            }
            if !comment.isEmpty {
                Divider()
            }
            if !comment.isEmpty {
                Divider()
            }
            if comments.count > 2 {
                ForEach(comments.suffix(2), id: \.self) { comment in
                    HStack {
                        Text(comment.username!).bold() +
                        Text("")
                        Text(comment.content!)
                    }
                    .padding([.leading])
                    .padding([.bottom], 3)
                }
            }
            else {
                ForEach(comments, id: \.self) { comment in
                    HStack {
                        Text(comment.username!).bold() +
                        Text("")
                        Text(comment.content!)
                    }
                    .padding([.leading])
                    .padding([.bottom], 3)
                }
            }
            
            if userViewModel.state == .signedIn && userViewModel.user.hasSetUsername! {
                HStack {
                    TextField(
                        "Add a comment...",
                        text: $comment
                    )
                    if !comment.isEmpty {
                        Button(action: {
                            FirestoreRequests().createComment(userID: userViewModel.user.uid!, postID: post.id!, commentID:  UUID().uuidString, content: comment, datePosted: Date(), username: userViewModel.user.username!) { data in
                                comments.append(data!)
                                comment = ""
                            }
                        }) {
                            Image(systemName: "plus.app")
                                .foregroundColor(.blue)
                                .multilineTextAlignment(.trailing)
                                .padding([.trailing])
                        }
                    }
                }
                .padding([.leading])
                .padding([.bottom], 3)
                .padding([.top], comment.isEmpty ? 0 : 3)
            }
        }
        .onAppear {
            numLikes = post.numLikes!
            FirestoreRequests().getCommentsForPost(post: post.id!) { data in
                comments = data!
            }
            FirestoreRequests().getUser(post.userID!) { data in
                postUser = data!
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.refreshPost)) { object in
            refreshPost()
        }
    }
    
    
    func refreshPost() {
        FirestoreRequests().getPost(postID: post.id!) { data in
            numLikes = data.numLikes!
        }
    }
}

