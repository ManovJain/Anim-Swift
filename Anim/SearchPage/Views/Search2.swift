//
//  Search2.swift
//  Anim
//
//  Created by Manovski on 4/4/23.
//

import SwiftUI

struct Search2: View {
    
    @EnvironmentObject var networkRequests: NetworkRequests
    @EnvironmentObject var cameraModel: CameraViewModel
    @EnvironmentObject var foodViewModel: FoodViewModel
    @EnvironmentObject var navModel: NavModel
    @EnvironmentObject var userViewModel: UserViewModel
    
    @Environment(\.isSearching) private var isSearching: Bool
    
    @State private var searchResults: [FoodItem] = [FoodItem]()
    @State private var recentSearches: [String] = []
    @State private var productsViewed: [String] = []
    @State var searchText: String = ""
    @State private var loadingSearch: Bool = false
    @State private var index = 0
    @State var display: String = "Explore"
    @State var togglePreview = false
    @State var showUsernameMissingAlert: Bool = false
    @State var allPosts = [Post]()
    @State var followingPosts = [Post]()
    @State var usernameSet = false
    
    
    var banners = [
        ["inputImage": "Banner1", "location": "foodLog"],
        ["inputImage": "Banner2", "location": "animManager"],
        ["inputImage": "Banner3", "location": "animManager"] //this will be updated to the explore page!
    ]
    
    var body: some View {
        NavigationStack() {
            ZStack {
                Color("background").edgesIgnoringSafeArea(.all)
                if loadingSearch {
                    SearchLoadingScreen()
                }
                ScrollView{
                    if searchText.isEmpty && userViewModel.state == .signedIn {
                        VStack(alignment: .center){
                            HStack(alignment: .center, spacing: 10){
                                Spacer()
                                Button("Explore", action: {display = "Explore"})
                                    .buttonStyle(MenuButtonStyle())
                                Button("Filter", action: {
                                    if display == "Filter" {
                                        display = "Explore"
                                    } else {
                                        display = "Filter"
                                    }
                                })
                                .buttonStyle(MenuButtonStyle())
                                Spacer()
                            }
                            if display == "Filter"{
                                FilterModalView()
                                    .padding(5)
                            }
                            TabView(selection: $index){
                                ForEach((0...banners.count-1), id: \.self) { index in
                                    Banner(inputImage: banners[index]["inputImage"]!, location: banners[index]["location"]!)
                                }
                            }
                            .frame(height: 200)
                            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .always))
                            VStack{
                                HStack(){
                                    Image(systemName: "clock")
                                    Text("Recently Viewed")
                                }
                                ScrollView(.horizontal){
                                    HStack{
                                        if searchText.isEmpty && userViewModel.state == .signedIn {
                                            ForEach(productsViewed, id: \.self) { product in
                                                RecentSearchView(id: product)
                                            }
                                        }
                                    }
                                }
                            }
                            Spacer()
                                .frame(height: 20)
                            VStack{
                                HStack(){
                                    Image(systemName: "star")
                                    Text("Trending Posts")
                                }
                                ScrollView(.horizontal){
                                    HStack{
                                        ForEach(allPosts, id: \.self) { post in
                                            PostView(post: post, togglePreview: $togglePreview, missingUsername: $showUsernameMissingAlert)
                                                .padding(5)
                                            Divider()
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
                                Spacer()
                            }
                            Spacer()
                        }
                    } else {
                        ForEach(searchResults, id: \._id) { result in
                            SearchResultButton(searchResults: searchResults, searchResult: result, searchText: searchText)
                        }
                    }
                }
            }
            
        }
        .padding()
        .background(Color("background"))
        .scrollContentBackground(.hidden)
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity
        )
        .foregroundColor(.primary)
        .searchable(text: $searchText, prompt: "Search for a food...")
        .font(Font.custom("DMSans-Medium", size: 15))
        .onSubmit(of: .search) {
            if !searchText.isEmpty {
                search(searchText: searchText)
            }
        }
        .onAppear {
            searchText = foodViewModel.searchTerm
            searchResults = foodViewModel.searchResults
            recentSearches = userViewModel.user.recentSearches ?? []
            if let viewed = userViewModel.user.productsViewed {
                if viewed.count > 7 {
                    productsViewed = viewed.suffix(7)
                }
                else {
                    productsViewed = viewed
                }
                productsViewed = productsViewed.reversed()
            }
        }
        .onChange(of: searchText) { searchText in
            if searchText.isEmpty && !isSearching {
                searchResults = [FoodItem]()
                foodViewModel.searchTerm = searchText
                foodViewModel.searchResults = [FoodItem]()
            }
        }
    }
    
    func search(searchText: String) {
        loadingSearch = true;
        var editedSearchText = searchText.replacingOccurrences(of: " ", with: "+")
        editedSearchText = editedSearchText.replacingOccurrences(of: "’", with: "")
        foodViewModel.searchTerm = editedSearchText
        if recentSearches.contains(searchText) {
            while let idx = recentSearches.firstIndex(of:searchText) {
                recentSearches.remove(at: idx)
            }
        }
        recentSearches.append(searchText)
        if let uid = userViewModel.user.uid {
            if uid != "" {
                if userViewModel.user.recentSearches!.contains(searchText) {
                    while let idx = userViewModel.user.recentSearches!.firstIndex(of:searchText) {
                        userViewModel.user.recentSearches!.remove(at: idx)
                    }
                }
                userViewModel.user.recentSearches?.append(searchText)
                recentSearches = userViewModel.user.recentSearches!
            }
        }
        networkRequests.getOpenFoodSearch(searchTerm: editedSearchText) { data in
            loadingSearch = false;
            searchResults = data!.products
            foodViewModel.searchResults = data!.products
        }
    }
}
