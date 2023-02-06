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
                    
                }
                .foregroundColor(.primary)
                .searchable(text: $searchText, prompt: "Search for a food...")
                .onSubmit(of: .search) {
                    if !searchText.isEmpty {
                        var editedSearchText = searchText.replacingOccurrences(of: " ", with: "+")
                        editedSearchText = editedSearchText.replacingOccurrences(of: "’", with: "")
                        foodViewModel.searchTerm = editedSearchText
                        recentSearches.append(editedSearchText)
                        //add to user vm
                        if let uid = userViewModel.userModel.uid {
                            if uid != "" {
                                userViewModel.userModel.recentSearches?.append(editedSearchText)
                            }
                        }
                        networkRequests.getOpenFoodSearch(searchTerm: editedSearchText) { data in
                            searchResults = data!.products
                            foodViewModel.searchResults = data!.products
                        }
                    }
                }
            }
        }
        .onAppear {
            searchText = foodViewModel.searchTerm
            searchResults = foodViewModel.searchResults
            recentSearches = userViewModel.userModel.recentSearches ?? []
        }
        .onChange(of: searchText) { searchText in
            if searchText.isEmpty && !isSearching {
                searchResults = [FoodItem]()
                
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
    
}
