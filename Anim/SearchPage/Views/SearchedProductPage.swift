//
//  ProductPage.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 12/2/22.
//

import SwiftUI
import CachedAsyncImage

struct SearchedProductPage: View {
    
    @EnvironmentObject var networkRequests: NetworkRequests
    @EnvironmentObject var camModel: CameraViewModel
    @EnvironmentObject var foodViewModel: FoodViewModel
    
    @State var product: Product?
    
    @State var status: Int?
    
    @State var alertShown = false
    
    var body: some View {
        ZStack {
            if camModel.searchedBarcode == "No Barcode Scanned Yet" {
                VStack {
                    Text("No Barcode Scanned Yet")
                        .font(.title)
                        .fontWeight(.bold)
                        .frame(alignment: .center)
                    Image("logo")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 250)
                }
            }
            else {
                if status == nil{
                    Text("Waiting for database...")
                        .font(.title)
                        .fontWeight(.bold)
                        .frame(alignment: .center)
                }
                else if status == 0 {
                    Text("Product not found")
                        .font(.title)
                        .fontWeight(.bold)
                        .frame(alignment: .center)
                }
                else {
                    ZStack {
                        Group {
                            ProductInfo(foundProduct: product!, fromSearch: true, alertShown: $alertShown)
                                .blur(radius: alertShown ? 20 : 0)
                                .animation(.spring())
                        }
                        .allowsHitTesting(!alertShown)
                        if alertShown {
                            AlertView(alertShown: $alertShown)
                                .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.2)))
                        }
                    }
                    .frame(width: UIScreen.screenWidth - 50)
                }
            }
        }
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity
        )
        .onAppear {
            networkRequests.getFoodByBarcode(barcode: camModel.searchedBarcode) { data in
                status = data?.status
                product = data?.product
            }
        }
    }
}


