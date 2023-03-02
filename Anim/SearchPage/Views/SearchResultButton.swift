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
                if searchResult.product_name != nil || searchResult.product_name != ""{

                        if let name = searchResult.product_name{
                            if name != ""{
                                Text(name.capitalized)
                                    .font(Font.custom("DMSans-Medium", size: 15))
                                    .foregroundColor(Color("background"))
                                    .colorInvert()
                                    .lineLimit(1)
                            }
                        }
                    
                    Spacer()
                    if let nScore = searchResult.nutriscore_grade {
                        if nScore == "a" {
                            Text(nScore.uppercased())
                                .font(Font.custom("DMSans-Medium", size: 12))
                                .padding(5)
                                .background(.green)
                                .clipShape(Circle())
                                .foregroundColor(.primary)
                        }
                        else if nScore == "b" || nScore == "c" {
                            Text(nScore.uppercased())
                                .font(Font.custom("DMSans-Medium", size: 12))
                                .padding(5)
                                .background(.yellow)
                                .clipShape(Circle())
                                .foregroundColor(.primary)
                        }
                        else {
                            Text(nScore.uppercased())
                                .font(Font.custom("DMSans-Medium", size: 12))
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

