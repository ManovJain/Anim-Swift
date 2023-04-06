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
    @State var searchText: String = ""
    @State private var loadingSearch: Bool = false
    @State private var index = 0
    @State var display: String = "Explore"
    
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
                                    Text("Recent Searches")
                                }
                                ScrollView(.horizontal){
                                    HStack{
                                        if searchText.isEmpty && userViewModel.state == .signedIn {
                                            ForEach(userViewModel.user.productsViewed!, id: \.self) { favorite in
                                                RecentSearchView(id: favorite)
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
                                        ForEach((0...banners.count-1), id: \.self) { index in
                                            Image(uiImage: UIImage(named: "animLogoIconGreen") ?? UIImage())
                                                .resizable()
                                                .frame(width: 120, height: 120)
                                        }
                                    }
                                }
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
