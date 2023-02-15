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
    
    var body: some View {
        NavigationView{
            ZStack {
                Color("background").edgesIgnoringSafeArea(.all)
                List {
                    if searchText.isEmpty {
                        Section {
                            ForEach(recentSearches.reversed(), id: \.self) { result in
                                Button {
                                    searchText = result
                                    search(searchText: searchText)
                                } label: {
                                    Text(result)
                                }
                            }
                        } header: {
                            Text("Recent Searches")
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
            searchResults = data!.products
            foodViewModel.searchResults = data!.products
        }
    }
}
