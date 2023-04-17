//
//  RecentSearchView.swift
//  Anim
//
//  Created by Manovski on 4/5/23.
//

import Foundation
import SwiftUI
import CachedAsyncImage

struct RecentSearchView: View {
    
    @EnvironmentObject var networkRequests: NetworkRequests
    @EnvironmentObject var foodViewModel: FoodViewModel
    @EnvironmentObject var navModel: NavModel
    @EnvironmentObject var camModel: CameraViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    
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
            } label: {
                VStack{
                    CachedAsyncImage(
                        url: URL(string: product?.image_front_url ?? "https://i.imgur.com/9eJFAzo.png")) { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                        } placeholder: {
                            ProgressView()
                        }
                    Text(product?.product_name_en ?? "")
                        .font(Font.custom("DMSans-Medium", size: 15))
                        .foregroundColor(Color("AnimGreen"))
                        .lineLimit(1)
                        .aspectRatio(contentMode: .fit)
                        .frame(minWidth: 80, maxWidth: 80)
                }
                .frame(minWidth: 100, maxWidth: 100, minHeight: 100, maxHeight: 100)
            }
        }
        .onAppear(){
            networkRequests.getFoodByBarcode(barcode: id) { data in
                if let data {
                    status = (data.status)!
                    if status == 0 {
                        print(id)
                        userViewModel.user.productsViewed = userViewModel.user.productsViewed!.filter{ $0 != id }
                    } else if status == 1 {
                        product = (data.product)!
                    }
                    
                }
                else {
                    print(id)
                    userViewModel.user.productsViewed = userViewModel.user.productsViewed!.filter{ $0 != id }
                }
            }
        }
    }
}


