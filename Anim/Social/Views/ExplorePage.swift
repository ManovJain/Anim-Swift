//
//  InteractPage.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 4/3/23.
//

import SwiftUI
import Combine

struct ExplorePage: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    @EnvironmentObject var exploreViewModel: ExploreViewModel
    
    @State var allPosts = [Post]()
    
    @State var togglePreview = false
    
    @State var usernameSet = false
    
    @State var showTopBar = true
    
    @State var scrollOffset: CGFloat = 0.00
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                Color("background").edgesIgnoringSafeArea(.all)
                VStack {
                    if exploreViewModel.dismissedUsername || usernameSet {
                        if showTopBar {
                            ExploreToggle()
                                .transition(.move(edge: .top))
                        }
                        switch exploreViewModel.feedType {
                        case .explore:
                            ScrollView {
                                VStack {
                                    ForEach(allPosts, id: \.self) { post in
                                        PostView(post: post, togglePreview: $togglePreview)
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
//                .toolbar {
//                    if userViewModel.state == .signedIn {
//                        if usernameSet {
//                            ToolbarItem {
//                                NavigationLink(destination: CreatePostView()) {
//                                    Image(systemName: "plus.app")
//                                        .foregroundColor(Color("background"))
//                                }
//                            }
//                        }
//                        else if exploreViewModel.dismissedUsername {
//                            ToolbarItem {
//                                NavigationLink(destination: CreatePostView()) {
//                                    Image(systemName: "person.crop.circle")
//                                        .foregroundColor(Color("background"))
//                                }
//                            }
//                        }
//                    }
//                }
            }
        }
        .onAppear {
            if userViewModel.state == .signedIn {
                usernameSet = userViewModel.user.hasSetUsername!
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
