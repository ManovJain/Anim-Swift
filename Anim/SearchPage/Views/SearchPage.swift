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
    
    @State private var searchResults: [FoodItem] = [FoodItem]()
    
    @State private var recentSearches: [String] = []
    
    @State var searchText: String = ""
    
    @Environment(\.isSearching) private var isSearching: Bool
    
    var body: some View {
        NavigationView{
            List {
                if searchText.isEmpty {
                    Section {
                        ForEach(recentSearches, id: \.self) { result in
                            Button {
                                searchText = result
                                networkRequests.getOpenFoodSearch(searchTerm: result) { data in
                                    searchResults = data!.products
                                    foodViewModel.searchResults = data!.products
                                }
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
            }.foregroundColor(.primary)
                .searchable(text: $searchText, prompt: "Search for a food...")
                .onSubmit(of: .search) {
                    if !searchText.isEmpty {
                        var editedSearchText = searchText.replacingOccurrences(of: " ", with: "+")
                        editedSearchText = editedSearchText.replacingOccurrences(of: "’", with: "")
                        foodViewModel.searchTerm = editedSearchText
                        networkRequests.getOpenFoodSearch(searchTerm: editedSearchText) { data in
                            searchResults = data!.products
                            foodViewModel.searchResults = data!.products
                        }
                    }
                }
        }
        .onAppear {
            searchText = foodViewModel.searchTerm
            searchResults = foodViewModel.searchResults
        }
        .onChange(of: searchText) { searchText in
            if searchText.isEmpty && !isSearching {
                searchResults = [FoodItem]()
                
            }
        }
        .padding()
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity
        )
    }
    
}
