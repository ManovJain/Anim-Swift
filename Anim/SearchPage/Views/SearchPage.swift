//
//  SearchPage.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 11/30/22.
//

import SwiftUI
import CachedAsyncImage

struct SearchPage: View {
    
    @EnvironmentObject var networkRequests: NetworkRequests
    
    @EnvironmentObject var cameraModel: CameraViewModel
    
    @EnvironmentObject var foodViewModel: FoodViewModel
    
    @EnvironmentObject var navModel: NavModel
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    @State private var searchResults: [FoodItem] = [FoodItem]()
    
    @State private var recentSearches: [String] = []
    
    @State var searchText: String = ""
    
    @Environment(\.isSearching) private var isSearching: Bool
    
    @State private var loadingSearch: Bool = false
    
    var body: some View {
        NavigationView{
            ZStack {
                Color("background").edgesIgnoringSafeArea(.all)
                if loadingSearch {
                    SearchLoadingScreen()
                }
                List {
                    if searchText.isEmpty && userViewModel.state == .signedIn {
                        Section {
                            if recentSearches.count < 4 {
                                ForEach(recentSearches.reversed(), id: \.self) { result in
                                    Button {
                                        searchText = result
                                        search(searchText: searchText)
                                    } label: {
                                        Text(result)
                                            .font(Font.custom("DMSans-Medium", size: 15))
                                    }
                                }
                            }
                            else {
                                ForEach(recentSearches.reversed()[0...4], id: \.self) { result in
                                    Button {
                                        searchText = result
                                        search(searchText: searchText)
                                    } label: {
                                        Text(result)
                                            .font(Font.custom("DMSans-Medium", size: 15))
                                    }
                                }
                            }
                        } header: {
                            Text("Recent Searches")
                                .font(Font.custom("DMSans-Medium", size: 12))
                        }
                        Section {
                            FilterModalView()
                        } header: {
                            Text("Filter & Sort")
                                .font(Font.custom("DMSans-Medium", size: 12))
                        }
                    }
                    else {
                        ForEach(searchResults, id: \._id) { result in
                            SearchResultButton(searchResults: searchResults, searchResult: result, searchText: searchText)
                        }
                    }
                    
                }
                .foregroundColor(.primary)
                .searchable(text: $searchText, prompt: "Search for a food...")
                .font(Font.custom("DMSans-Medium", size: 15))
                .onSubmit(of: .search) {
                    if !searchText.isEmpty {
                        search(searchText: searchText)
                    }
                }
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
        .padding()
        .background(Color("background"))
        .scrollContentBackground(.hidden)
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity
        )
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
        //add to user vm
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
