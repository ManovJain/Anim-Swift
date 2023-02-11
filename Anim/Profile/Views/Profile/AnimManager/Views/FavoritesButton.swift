//
//  FavoritesButton.swift
//  Anim
//
//  Created by Manovski on 2/8/23.
//

import Foundation
import SwiftUI

struct FavoritesButton: View {
    @EnvironmentObject var networkRequests: NetworkRequests
    @EnvironmentObject var foodViewModel: FoodViewModel
    @EnvironmentObject var navModel: NavModel
    @EnvironmentObject var camModel: CameraViewModel
    
    @State var product: Product?
    @State var status: Int?
    @State var id: String
    
    
    
    var body: some View {
        VStack {
            Spacer()
            Button() {
                foodViewModel.product = product
                foodViewModel.status = status
                camModel.scannedBarcode = "No Barcode Scanned Yet"
                navModel.currentPage = .food
                print("Button tapped!")
            } label: {
                VStack{
                    HStack{
                        AsyncImage(
                            url: URL(string: product?.image_front_url ?? "https://i.imgur.com/9eJFAzo.png")) { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 80, height: 80)
                                    .clipShape(Rectangle())
                                    .background(Color("background"))
                            } placeholder: {
                                ProgressView()
                            }
                        if let nScore = product?.nutriscore_grade {
                            if nScore == "a" {
                                Text(nScore.uppercased())
                                    .font(.caption)
                                    .padding(10)
                                    .background(.green)
                                    .clipShape(Circle())
                                    .foregroundColor(.primary)
                            }
                            else if nScore == "b" || nScore == "c" {
                                Text(nScore.uppercased())
                                    .font(.caption)
                                    .padding(10)
                                    .background(.yellow)
                                    .clipShape(Circle())
                                    .foregroundColor(.primary)
                            }
                            else {
                                Text(nScore.uppercased())
                                    .font(.caption)
                                    .padding(10)
                                    .background(.red)
                                    .clipShape(Circle())
                                    .foregroundColor(.primary)
                            }
                        }
                    }
                    Text(product?.product_name_en ?? "name")
                        .foregroundColor(.green)
                        .lineLimit(1)
                }
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.green, lineWidth: 3))
            }
            .frame(
                minWidth: 0,
                maxWidth: .infinity,
                minHeight: 0,
                maxHeight: .infinity
            )
            Spacer()
        }
        .onAppear(){
            networkRequests.getFoodByBarcode(barcode: id) { data in
                status = (data?.status)!
                product = (data?.product)!
            }
        }
    }
}

