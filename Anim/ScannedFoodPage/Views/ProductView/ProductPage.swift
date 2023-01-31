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
    
    @State var tagAlertShown = false
    
    @State var gradeAlertShown = false
    
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
                        ProductInfo(foundProduct: product!, tagAlertShown: $tagAlertShown, gradeAlertShown: $gradeAlertShown)
                            .blur(radius: tagAlertShown ? 20 : 0)
                            .blur(radius: gradeAlertShown ? 20 : 0)
                            .animation(.spring())
                    }
                    .allowsHitTesting(!tagAlertShown)
                    if tagAlertShown {
                        TagAlertView(tagAlertShown: $tagAlertShown)
                            .transition(AnyTransition.opacity.animation(.easeInOut(duration: 0.2)))
                    }
                    if gradeAlertShown {
                        GradeAlertView(gradeAlertShown: $gradeAlertShown)
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
                    //userVM.currentUser.scannedProduct.append
                }
            }
            else if foodViewModel.product != nil {
                status = foodViewModel.status
                product = foodViewModel.product
            }
        }
    }
}


