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
    @EnvironmentObject var userViewModel: UserViewModel
    
    @State var product: Product?
    
    @State var status: Int?
    
    @State var tagAlertShown = false
    
    @State var gradeAlertShown = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("background").edgesIgnoringSafeArea(.all)
                if status == nil{
                    Text("Search or scan a product")
                        .font(.title)
                        .fontWeight(.bold)
                        .frame(alignment: .center)
                }
                else if status == 0 {
                    Text("Oh no! We don't have data on this product yet but our team is currently working to solve that issue.")
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
                        if status != 1 {
                            FirestoreRequests().addBarcodeToMissing(array: "missingBarcode", barcode: camModel.scannedBarcode)
                        }
                        if let uid = userViewModel.userModel.uid {
                            if uid != "" {
                                if !(userViewModel.userModel.productsViewed!.contains(camModel.scannedBarcode)) {
                                    userViewModel.userModel.productsScanned = userViewModel.userModel.productsScanned! + 1
                                    userViewModel.userModel.productsViewed?.append(camModel.scannedBarcode)
                                }
                                
                            }
                        }
                        //userVM.currentUser.scannedProduct.append
                    }
                }
                else if foodViewModel.product != nil {
                    status = foodViewModel.status
                    product = foodViewModel.product
                    if let uid = userViewModel.userModel.uid {
                        if uid != "" {
                            if !(userViewModel.userModel.productsViewed!.contains((foodViewModel.product?._id)!)) {
                                userViewModel.userModel.productsFromSearch = userViewModel.userModel.productsFromSearch! + 1
                                userViewModel.userModel.productsViewed?.append((foodViewModel.product?._id)!)
                            }
                        }
                    }
                }
            }
        }
    }
}

