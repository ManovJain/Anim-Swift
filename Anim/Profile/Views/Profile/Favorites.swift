//
//  Favorites.swift
//  Anim
//
//  Created by Manovski on 12/16/22.
//

import Foundation
import SwiftUI

struct Favorites: View {
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var networkRequests: NetworkRequests
    @EnvironmentObject var cameraModel: CameraViewModel
    @EnvironmentObject var foodViewModel: FoodViewModel
    @EnvironmentObject var navModel: NavModel
    
    let columns = [
            GridItem(.flexible()),
            GridItem(.flexible())
        ]
    
//    var favorites = ["saved", "liked", "disliked"]
    var favorites = ["saved"]
    var body: some View {
        Text("Favorites")
            .frame(alignment: .center)
            .font(.system(size: 30))
            .fontWeight(.bold)
        VStack(){
            HStack(){
                ForEach(favorites, id: \.self) { favorite in
                    Button(){
                        
                    } label: {
                        Text(favorite)
                            .foregroundColor(.white)
                            .fontWeight(.heavy)
                            .lineLimit(1)
                    }
                    .padding()
                    .background(.green)
                    .cornerRadius(15)
                    .clipShape(Capsule())
                }
            }
            VStack(alignment: .leading) {
                ScrollView{
                    ScrollView {
                                LazyVGrid(columns: columns, spacing: 20) {
                                    ForEach(userViewModel.userModel.favorites!, id: \.self) { favorite in
                                        Button() {
                                            print("Button tapped!")
                                            networkRequests.getFoodByBarcode(barcode: favorite) { data in
                                                foodViewModel.status = data?.status
                                                foodViewModel.product = data?.product
                                                cameraModel.scannedBarcode = "No Barcode Scanned Yet"
                                                navModel.currentPage = .food
                                            }   
                                        } label: {
                                            HStack{
                                                Image(systemName: "bird")
                                                    .foregroundColor(.indigo)
                                                Text(favorite)
                                                    .foregroundColor(.indigo)
                                                Spacer()

                                                Text("A")
                                                    .font(.caption)
                                                    .padding(10)
                                                    .background(.green)
                                                    .clipShape(Circle())
                                                    .foregroundColor(.primary)
                                                Spacer()
                                            }
                                            .padding()
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 4)
                                                    .stroke(.indigo, lineWidth: 4)
                                            )
                                        }
                                    }
                                }
                                .padding(.horizontal)
                            }
                            .frame(maxHeight: 300)
                }
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

struct Favorites_Previews: PreviewProvider {
    static var previews: some View {
        Favorites()
    }
}
