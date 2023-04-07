//
//  PostView.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 4/4/23.
//

import SwiftUI

enum PostAlert {
    case delete
    case follow
    case unfollow
}


struct PostView: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    @State var post: Post
    
    @Binding var togglePreview: Bool
    
    @State var postUser: User = User(uid: "", email: "")
    
    @State var numLikes = 0
    
    @State var comments = [Comment]()
    
    @State var comment: String = ""
    
    @State var postAlert: PostAlert = .delete
    
    @State var showPostAlert: Bool = false
    
    @Binding var missingUsername : Bool
    
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
                Spacer()
                if (postUser.uid! == userViewModel.user.uid!) {
                    Menu ("···") {
                        Button{ showPostAlert.toggle()
                            postAlert = .delete
                        }
                    label: {
                        Text ("Delete Post")
                            .frame(alignment: .center)
                    }
                    }
                    .foregroundColor(.gray)
                    .padding([.trailing])
                }
                else {
                    if userViewModel.state == .signedIn {
                        if userViewModel.user.following!.contains(postUser.uid!) {
                            Button("Unfollow") {
                                if userViewModel.user.hasSetUsername! {
                                    showPostAlert.toggle()
                                    postAlert = .unfollow
                                }
                                else {
                                    missingUsername.toggle()
                                }
                            }
                            .padding([.trailing])
                        }
                        else if userViewModel.user.pendingRequests!.contains(postUser.uid!) {
                            Text("Requested")
                                .foregroundColor(.gray)
                        }
                        else {
                            Button("Follow") {
                                if userViewModel.user.hasSetUsername! {
                                    showPostAlert.toggle()
                                        postAlert = .follow
                                }
                                else {
                                    missingUsername.toggle()
                                }
                            }
                            .padding([.trailing])
                        }
                    }
                }
            }
            .padding(.top, 1)
            .padding([.leading])
            URLPreview(previewURL: URL(string: post.content!)!, togglePreview: $togglePreview)
                .padding([.horizontal], 4)
            //MARK: Caption
            VStack (alignment: .leading, spacing: 3) {
                Text(post.caption!)
                    .font(Font.custom("DMSans-Medium", size: 16))
                Text("shared " + post.datePosted!.timeAgoDisplay())
                    .foregroundColor(.gray)
                    .font(Font.custom("DMSans-Medium", size: 10))
            }
            .padding([.leading])
            .padding([.bottom], 3)
            //MARK: Like Button and Like Count
            HStack (alignment: .center) {
                if userViewModel.state == .signedIn {
                    Button {
                        if userViewModel.user.hasSetUsername! {
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
                        }
                        else {
                            missingUsername.toggle()
                        }
                    } label: {
                        Image(systemName:  (userViewModel.user.likedPosts?.contains(post.id!))! ? "heart.fill" : "heart")
                            .resizable()
                            .frame(width: 16, height: 16)
                            .foregroundColor( (userViewModel.user.likedPosts?.contains(post.id!))! ? .red : .gray)
                        
                    }
                }
                else {
                    Image(systemName:  ("heart"))
                        .frame(width: 16, height: 16)
                        .foregroundColor(.gray)
                }
                Text("\(numLikes)")
                    .foregroundColor(.gray)
                
                Spacer()
                //MARK: Comments
                if userViewModel.state == .signedIn {
                    if userViewModel.user.hasSetUsername! {
                        NavigationLink(destination: CommentsView(post: post, anim: postUser.anim ?? "animLogoIcon", comments: comments)) {
                            Image(systemName:  ("message"))
                                .frame(width: 16, height: 16)
                                .foregroundColor(.gray)
                        }
                    }
                    else {
                        Button(action: {
                            missingUsername.toggle()
                        }) {
                            Image(systemName:  ("message"))
                                .frame(width: 16, height: 16)
                                .foregroundColor(.gray)
                        }
                    }
                }
                else {
                    NavigationLink(destination: CommentsView(post: post, anim: postUser.anim ?? "animLogoIcon", comments: comments)) {
                        Image(systemName:  ("message"))
                            .frame(width: 16, height: 16)
                            .foregroundColor(.gray)
                    }
                }
                Text("\(comments.count)")
                    .foregroundColor(.gray)
                    .font(Font.custom("DMSans-Medium", size: 16))
            }
            .padding([.horizontal])
            .padding([.bottom], 4)
        }
        .alert(isPresented: $showPostAlert) {
            switch postAlert {
            case .delete:
                return Alert(title: Text("Delete post?"), message: Text("This post will be permanently deleted and cannot be recovered."), primaryButton: .default(Text("Yes")) {
                    FirestoreRequests().deletePost(postID: post.id!)
                    NotificationCenter.default.post(name: NSNotification.refreshPosts, object: nil)
                },secondaryButton: .default(Text("No")) {})
            case .follow:
                return Alert(title: Text("Follow \(post.username!)?"), message: Text("They will see that you are following them."), primaryButton: .default(Text("Yes"))  {
                    if post.isPublic! {
                        FirestoreRequests().followUser(posterID: postUser.uid!, followerID: userViewModel.user.uid!)
                        userViewModel.user.following?.append(postUser.uid!)
                        NotificationCenter.default.post(name: NSNotification.refreshFollowingPosts, object: nil)
                    }
                    else {
                        FirestoreRequests().followPrivateUser(posterID: postUser.uid!, followerID: userViewModel.user.uid!)
                        userViewModel.user.pendingRequests?.append(postUser.uid!)
                    }
                } ,secondaryButton: .default(Text("No")) {})
            case .unfollow:
                return Alert(title: Text("Unfollow \(post.username!)?"), message: Text("They will see that you are no longer following them."), primaryButton: .default(Text("Yes")){
                    userViewModel.user.following! = userViewModel.user.following!.filter {$0 != postUser.uid!}
                    FirestoreRequests().unFollowUser(posterID: postUser.uid!, followerID: userViewModel.user.uid!)
                    NotificationCenter.default.post(name: NSNotification.refreshFollowingPosts, object: nil)
                } ,secondaryButton: .default(Text("No")) {})
            }
        }
        .onAppear {
            numLikes = post.numLikes!
            FirestoreRequests().getCommentsForPost(post: post.id!) { data in
                comments = data!.sorted{ $0.datePosted! > $1.datePosted!}
            }
            FirestoreRequests().getUser(post.userID!) { data in
                postUser = data!
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.refreshPost)) { object in
            refreshPost()
        }
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.refreshComments)) { object in
            FirestoreRequests().getCommentsForPost(post: post.id!) { data in
                comments = data!.sorted{ $0.datePosted! > $1.datePosted!}
            }
        }
    }
    
    
    func refreshPost() {
        FirestoreRequests().getPost(postID: post.id!) { data in
            numLikes = data.numLikes!
        }
    }
}

