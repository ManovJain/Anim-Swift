//
//  InteractPage.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 4/3/23.
//

import SwiftUI
import Combine

enum UsernameIssue {
    case length
    case taken
}


struct ExplorePage: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    @EnvironmentObject var exploreViewModel: ExploreViewModel
    
    @State var allPosts = [Post]()
    
    @State var followingPosts = [Post]()
    
    @State var togglePreview = false
    
    @State var usernameSet = false
    
    @State var showTopBar = true
    
    @State var scrollOffset: CGFloat = 0.00
    
    @State var showUsernameMissingAlert: Bool = false
    
    @State var showUsernameIssue: Bool = false
    
    @State var username: String = ""
    
    @State var usernameIssue: UsernameIssue = .length

    var body: some View {
        
        NavigationView {
            ZStack {
                Color("background").edgesIgnoringSafeArea(.all)
                VStack {
                    if userViewModel.state == .signedIn && !usernameSet &&  !exploreViewModel.dismissedUsername {
                        UsernameInput()
                    }
                    else if exploreViewModel.dismissedUsername || userViewModel.state == .signedOut || usernameSet {
                        if showTopBar {
                            ExploreToggle()
                                .transition(.move(edge: .top))
                        }
                        switch exploreViewModel.feedType {
                        case .explore:
                            ScrollView(showsIndicators: false) {
                                VStack {
                                    ForEach(allPosts, id: \.self) { post in
                                        PostView(post: post, togglePreview: $togglePreview, missingUsername: $showUsernameMissingAlert)
                                        Divider()
                                    }
                                }
                                .background(GeometryReader {
                                    return Color.clear.preference(key: ViewOffsetKey.self,
                                                                  value: -$0.frame(in: .named("scroll")).origin.y)
                                })
                                .onPreferenceChange(ViewOffsetKey.self) { offset in
                                    withAnimation {
                                        if offset > 50 {
                                            showTopBar = false
                                        } else  {
                                            showTopBar = true
                                        }
                                    }
                                    scrollOffset = offset
                                }
                            }
                            .padding([.top], showTopBar ? -5 : 20)
                            .padding([.bottom], 40)
                            .coordinateSpace(name: "scroll")
                            
                        case .following:
                            ScrollView(showsIndicators: false) {
                                VStack {
                                    ForEach(followingPosts, id: \.self) { post in
                                        PostView(post: post, togglePreview: $togglePreview, missingUsername: $showUsernameMissingAlert)
                                        Divider()
                                    }
                                }
                                .background(GeometryReader {
                                    return Color.clear.preference(key: ViewOffsetKey.self,
                                                                  value: -$0.frame(in: .named("scroll")).origin.y)
                                })
                                .onPreferenceChange(ViewOffsetKey.self) { offset in
                                    withAnimation {
                                        if offset > 50 {
                                            showTopBar = false
                                        } else  {
                                            showTopBar = true
                                        }
                                    }
                                    scrollOffset = offset
                                }
                            }
                            .padding([.top], showTopBar ? -5 : 20)
                            .padding([.bottom], 40)
                            .coordinateSpace(name: "scroll")
                        }
                    }
                }
            }
            .overlay( ((userViewModel.state == .signedIn && (usernameSet || exploreViewModel.dismissedUsername)) ? CreatePostButton(missingUsername: $showUsernameMissingAlert).position(x: UIScreen.screenWidth - 30, y: UIScreen.screenHeight - 165) : nil)
            )
            
        }
        .alert("Uh Oh", isPresented: $showUsernameMissingAlert, actions: {
            TextField("Username", text: $username)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
            Button("Create Username", action: {
                createUsername()
            })
            Button("Create Later", role: .cancel, action: {})
        }, message: {
            Text("You need to create a username to access that feature.")
        })
        .alert(isPresented: $showUsernameIssue) {
            switch usernameIssue {
            case .length:
                return Alert(title: Text("Invalid Username"), message: Text("Username must be between 3 and 15 characters."), dismissButton: .default(Text("OK")) {showUsernameMissingAlert.toggle()})
            case .taken:
                return Alert(title: Text("Invalid Username"), message: Text("Username is already in use."), dismissButton: .default(Text("OK")) {showUsernameMissingAlert.toggle()})
            }
        }
        .onAppear {
            if userViewModel.state == .signedIn {
                usernameSet = userViewModel.user.hasSetUsername!
            }
            
            FirestoreRequests().getAllPosts { data in
                allPosts = data!.sorted{ $0.datePosted! > $1.datePosted!}
            }
            if userViewModel.state == .signedIn {
                FirestoreRequests().getFollowingPosts(following: userViewModel.user.following!) { data in
                    followingPosts = data!.sorted{ $0.datePosted! > $1.datePosted!}
                }
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.refreshPosts)) { object in
            FirestoreRequests().getAllPosts { data in
                allPosts = data!.sorted{ $0.datePosted! > $1.datePosted!}
            }
            if userViewModel.state == .signedIn {
                FirestoreRequests().getFollowingPosts(following: userViewModel.user.following!) { data in
                    followingPosts = data!.sorted{ $0.datePosted! > $1.datePosted!}
                }
            }
        }
        
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.refreshFollowingPosts)) { object in
            if userViewModel.state == .signedIn {
                FirestoreRequests().getFollowingPosts(following: userViewModel.user.following!) { data in
                    followingPosts = data!.sorted{ $0.datePosted! > $1.datePosted!}
                }
            }
        }
        
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.usernameCreated)) { object in
            if userViewModel.state == .signedIn {
                usernameSet = userViewModel.user.hasSetUsername!
            }
        }
    }
    
    func checkUsername(completion: @escaping (UsernameIssues) -> ()) {
        if username.count >= 3 && username.count <= 15 {
            FirestoreRequests().checkUsername(username: username) { data in
                if data {
                    completion(.taken)
                }
                else {
                    completion(.valid)
                }
            }
        }
        else {
            completion(.length)
        }
    }
    
    func createUsername() {
        checkUsername() { data in
            if data == .valid {
                print(username)
                    userViewModel.user.username = username
                    userViewModel.user.hasSetUsername = true
                    usernameSet = true
                    FirestoreRequests().addUsernameToArray(username: username)
            }
            if data == .taken {
                usernameIssue = .taken
                showUsernameIssue.toggle()
            }
            if data == .length {
                usernameIssue = .length
                showUsernameIssue.toggle()
            }
        }
    }
}
