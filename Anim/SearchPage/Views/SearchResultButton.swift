//
//  SearchResultButton.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 1/27/23.
//

import SwiftUI

struct SearchResultButton: View {
    
    @EnvironmentObject var networkRequests: NetworkRequests
    
    @EnvironmentObject var foodViewModel: FoodViewModel
    
    @EnvironmentObject var cameraModel: CameraViewModel
    
    @EnvironmentObject var navModel: NavModel
    
    var searchResults: [FoodItem]
    
    var searchResult: FoodItem
    
    var searchText: String
    
    var body: some View {
        Button {
            networkRequests.getFoodByBarcode(barcode: searchResult.code!) { data in
                foodViewModel.status = data?.status
                foodViewModel.product = data?.product
                foodViewModel.searchResults = searchResults
                foodViewModel.searchTerm = searchText
                cameraModel.scannedBarcode = "No Barcode Scanned Yet"
                navModel.currentPage = .food
            }
        } label: {
            HStack{
                if searchResult.product_name_en != nil || searchResult.product_name_en != ""{
//                    AsyncImage(
//                        url: URL(string: searchResult.image_front_url ?? "https://spng.pngfind.com/pngs/s/5-56881_apple-icon-apple-icon-cartoon-png-transparent-png.png")) { image in
//                            image.resizable()
//                                .frame(width: 45, height: 45)
//                        } placeholder: {
//                            ProgressView()
//                        }
//                        .padding()
                    if let name = searchResult.product_name_en{
                        if name != ""{
                            Text(name)
                                .font(.headline)
                                .lineLimit(1)
                        }
                    }
                    Spacer()
                    if let nScore = searchResult.nutriscore_grade {
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
        }
        .frame(height: 40)
    }
}

