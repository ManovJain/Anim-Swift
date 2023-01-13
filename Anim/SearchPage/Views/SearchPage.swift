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
    
    @State private var SearchResult: [FoodItem] = [FoodItem]()
    
    @State var searchText: String = ""
    
    @State var foundTopFood: Bool = false
    
    @Environment(\.isSearching) private var isSearching: Bool
    
    var body: some View {
        NavigationView{
            List {
                ForEach(SearchResult, id: \._id) { result in
                    NavigationButton(
                        action: {cameraModel.searchedBarcode = result.code!},
                        destination: {SearchedProductPage()},
                        label:
                    {
                        HStack{
                            if result.product_name_en != nil {
                                CachedAsyncImage(
                                    url: URL(string: result.image_front_url ?? "https://spng.pngfind.com/pngs/s/5-56881_apple-icon-apple-icon-cartoon-png-transparent-png.png")) { image in
                                        image.resizable()
                                                    .frame(width: 45, height: 45)
                                    } placeholder: {
                                        ProgressView()
                                    }
                                    .padding()
                                    if let name = result.product_name_en{
                                        if name != ""{
                                            Text(name)
                                                .font(.headline)
                                        }
                                    }
                                    Spacer()
                                    if let nScore = result.nutriscore_grade {
                                        if nScore == "a" {
                                            Text(nScore.uppercased())
                                                .font(.caption)
                                                .padding(5)
                                                .background(.green)
                                                .clipShape(Circle())
                                                .foregroundColor(.primary)
                                        }
                                        else if nScore == "b" || nScore == "c" {
                                            Text(nScore.uppercased())
                                                .font(.caption)
                                                .padding(5)
                                                .background(.yellow)
                                                .clipShape(Circle())
                                                .foregroundColor(.primary)
                                        }
                                        else {
                                            Text(nScore.uppercased())
                                                .font(.caption)
                                                .padding(5)
                                                .background(.red)
                                                .clipShape(Circle())
                                                .foregroundColor(.primary)
                                        }
                                    }
                            }
                        }
                    })

                }
            }.foregroundColor(.primary)
            .searchable(text: $searchText, prompt: "Search for a food...")
            .onSubmit(of: .search) {
                if !searchText.isEmpty {
                    var editedSearchText = searchText.replacingOccurrences(of: " ", with: "+")
                    editedSearchText = editedSearchText.replacingOccurrences(of: "’", with: "")
                    print(editedSearchText)
                    networkRequests.getOpenFoodSearch(searchTerm: editedSearchText) { data in
                        SearchResult = data!.products
                    }
                }
            }
        }
        .onChange(of: searchText) { searchText in
            if searchText.isEmpty && !isSearching {
                SearchResult = [FoodItem]()

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

struct SearchPage_Previews: PreviewProvider {
    static var previews: some View {
        SearchPage()
    }
}
