//
//  CommentsView.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 4/5/23.
//

import SwiftUI

struct CommentsView: View {
    
    @State var post: Post
    @State var anim: String
    @State var comments = [Comment]()
    @State var selectedCommentID: String = ""
    @State var comment: String = ""
    @EnvironmentObject var userViewModel: UserViewModel
    @State var deleteCommentPressed: Bool = false
    
    var body: some View {
        VStack {
            ZStack {
                Color("background").edgesIgnoringSafeArea(.all)
                ScrollView {
                    VStack(alignment: .leading) {
                        HStack {
                            Image(anim)
                                .resizable()
                                .frame(width: 30, height: 30, alignment: .leading)
                                .padding(5)
                                .overlay(
                                    Circle()
                                        .stroke(.primary, lineWidth: 2)
                                )
                            VStack (alignment: .leading) {
                                HStack {
                                    Text(post.username!)
                                        .fontWeight(.bold)
                                    Text(post.datePosted!.timeAgoDisplay())
                                        .foregroundColor(.gray)
                                        .font(Font.custom("DMSans-Medium", size: 16))
                                }
                                Text(post.caption!)
                            }
                        }
                        Divider()
                        ForEach(comments, id: \.self) { comment in
                            VStack (alignment: .leading, spacing: 3) {
                                HStack  {
                                    Text(comment.username!)
                                        .fontWeight(.bold)
                                    Text(comment.datePosted!.timeAgoDisplay())
                                        .foregroundColor(.gray)
                                        .font(Font.custom("DMSans-Medium", size: 16))
                                    Spacer()
                                    if (comment.userID! == userViewModel.user.uid!) {
                                        Menu ("···") {
                                            Button{ deleteCommentPressed.toggle()
                                                selectedCommentID = comment.id!
                                            }
                                        label: {
                                            Text ("Delete Comment")
                                                .frame(alignment: .center)
                                                .font(Font.custom("DMSans-Medium", size: 16))
                                        }
                                        }
                                        .foregroundColor(.gray)
                                        .padding([.trailing])
                                    }
                                }
                                Text(comment.content!)
                            }
                            .padding(.bottom)
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
                            .padding()
                            .overlay(
                                Capsule()
                                    .stroke(Color("AnimGreen"), lineWidth: 1)
                            )
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                }
            }
        }
        .alert("Are you sure you want to delete this comment?", isPresented: $deleteCommentPressed) {
            Button("No", role: .cancel) { }
            Button("Yes") {
                FirestoreRequests().deleteComment(commentID: selectedCommentID)
                comments = comments.filter {$0.id != selectedCommentID}
                NotificationCenter.default.post(name: NSNotification.refreshPosts, object: nil)
            }
        }
    }
}
