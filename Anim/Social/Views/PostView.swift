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
    
    @State var deletePostPressed: Bool = false
    
    @State var followPressed: Bool = false
    
    @State var unfollowPressed: Bool = false
    
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
                        Button{ deletePostPressed.toggle()}
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
                                    unfollowPressed.toggle()
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
                                    followPressed.toggle()
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
                Text("shared " + post.datePosted!.timeAgoDisplay())
                    .foregroundColor(.gray)
                    .font(.system(size: 10))
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
            }
            .padding([.horizontal])
            .padding([.bottom], 4)
        }
        .alert("Are you sure you want to delete this post?", isPresented: $deletePostPressed) {
            Button("No", role: .cancel) { }
            Button("Yes") {
                FirestoreRequests().deletePost(postID: post.id!)
                NotificationCenter.default.post(name: NSNotification.refreshPosts, object: nil)
            }
        }
        .alert("Follow \(post.username!)? They will see that you are following them.", isPresented: $followPressed) {
            Button("No", role: .cancel) { }
            Button("Yes") {
                if post.isPublic! {
                    FirestoreRequests().followUser(posterID: postUser.uid!, followerID: userViewModel.user.uid!)
                    userViewModel.user.following?.append(postUser.uid!)
                    NotificationCenter.default.post(name: NSNotification.refreshFollowingPosts, object: nil)
                }
                else {
                    FirestoreRequests().followPrivateUser(posterID: postUser.uid!, followerID: userViewModel.user.uid!)
                    userViewModel.user.pendingRequests?.append(postUser.uid!)
                }
            }
        }
        .alert("Unfollow \(post.username!)? They will see that you are no longer following them.", isPresented: $unfollowPressed) {
            Button("No", role: .cancel) { }
            Button("Yes") {
                userViewModel.user.following! = userViewModel.user.following!.filter {$0 != postUser.uid!}
                FirestoreRequests().unFollowUser(posterID: postUser.uid!, followerID: userViewModel.user.uid!)
                NotificationCenter.default.post(name: NSNotification.refreshFollowingPosts, object: nil)
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

