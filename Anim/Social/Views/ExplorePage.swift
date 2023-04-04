//
//  InteractPage.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 4/3/23.
//

import SwiftUI

struct ExplorePage: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    @EnvironmentObject var exploreViewModel: ExploreViewModel
    
    @State var allPosts = [Post]()
    
    @State var togglePreview = false
    
    @State var usernameSet = false
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                Color("background").edgesIgnoringSafeArea(.all)
                VStack {
                    if exploreViewModel.dismissedUsername || usernameSet {
                        ExploreToggle()
                        switch exploreViewModel.feedType {
                        case .explore:
                            ScrollView {
                                ForEach(allPosts, id: \.self) { post in
                                    PostView(post: post, togglePreview: $togglePreview)
                                    Divider()
                                }
                            }
                            .padding([.bottom], 40)
                        case .following:
                            List(allPosts, id: \.self) { post in
                                VStack {
                                    URLPreview(previewURL: URL(string: post.content!)!, togglePreview: $togglePreview)
                                    Text(post.caption!)
                                }
                            }
                            .background(.clear)
                        }
                    }
                    else {
                        UsernameInput()
                    }
                }
                .toolbar {
                    if userViewModel.state == .signedIn {
                        if usernameSet {
                            ToolbarItem {
                                NavigationLink(destination: CreatePostView()) {
                                    Image(systemName: "plus.app")
                                        .foregroundColor(Color("background"))
                                }
                            }
                        }
                        else if exploreViewModel.dismissedUsername {
                            ToolbarItem {
                                NavigationLink(destination: CreatePostView()) {
                                    Image(systemName: "person.crop.circle")
                                        .foregroundColor(Color("background"))
                                }
                            }
                        }
                    }
                }
            }
        }
        .onAppear {
            if userViewModel.state == .signedIn {
                usernameSet = userViewModel.user.hasSetUsername!
                print("check")
            }
            
            FirestoreRequests().getAllPosts { data in
                allPosts = data!.sorted{ $0.datePosted! > $1.datePosted!}
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.refreshPosts)) { object in
            FirestoreRequests().getAllPosts { data in
                allPosts = data!.sorted{ $0.datePosted! > $1.datePosted!}
            }
        }
        
        .onReceive(NotificationCenter.default.publisher(for: NSNotification.usernameCreated)) { object in
            if userViewModel.state == .signedIn {
                usernameSet = userViewModel.user.hasSetUsername!
            }
        }
    }
}
