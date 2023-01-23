//
//  ProductPage.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 12/2/22.
//

import SwiftUI
import CachedAsyncImage

struct ProductPage: View {
    
    @EnvironmentObject var networkRequests: NetworkRequests
    @EnvironmentObject var camModel: CameraViewModel
    @EnvironmentObject var foodViewModel: FoodViewModel
    
    @State var product: Product?
    
    @State var status: Int?
    
    @State var alertShown = false
    
    var body: some View {
        NavigationView {
            if status == nil{
                Text("Search or scan a product")
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
                        ProductInfo(foundProduct: product!, alertShown: $alertShown)
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
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity
        )
        .onAppear {
            
            if camModel.scannedBarcode != "No Barcode Scanned Yet" {
                networkRequests.getFoodByBarcode(barcode: camModel.scannedBarcode) { data in
                    status = data?.status
                    product = data?.product
                }
            }
            else if foodViewModel.product != nil {
                status = foodViewModel.status
                product = foodViewModel.product
            }
        }
    }
}


