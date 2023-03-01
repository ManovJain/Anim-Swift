//
//  ProductPage.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 12/2/22.
//

import SwiftUI
import CachedAsyncImage

struct ProductPage: View {
    
    var iconVM = IconVM()
    
    @EnvironmentObject var networkRequests: NetworkRequests
    @EnvironmentObject var camModel: CameraViewModel
    @EnvironmentObject var foodViewModel: FoodViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    
    @State var product: Product?
    
    @State var status: Int?
    
    @State var tagAlertShown = false
    
    @State var gradeAlertShown = false
    
    @State var iconEarned = "default"
    
    @State var findingProduct = false

    var body: some View {
        NavigationView {
            ZStack {
                Color("background").edgesIgnoringSafeArea(.all)
                if findingProduct {
                    ProgressView()
                }
                else if status == nil{
                    Text("Search or scan a product")
                        .font(Font.custom("DMSans-Medium", size: 24))
                        .foregroundColor(Color("AnimGreen"))
                        .frame(alignment: .center)
                }
                else if status == 0 {
                    Text("Oh no! We don't have data on this product yet but our team is currently working to solve that issue.")
                        .padding()
                        .font(Font.custom("DMSans-Medium", size: 24))
                        .foregroundColor(Color("AnimGreen"))
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
                NotificationCenter.default.post(name: NSNotification.showAnimAlert, object: nil)
                if camModel.scannedBarcode != "No Barcode Scanned Yet" {
                    findingProduct = true
                    networkRequests.getFoodByBarcode(barcode: camModel.scannedBarcode) { data in
                        findingProduct = false
                        status = data?.status
                        product = data?.product
                        if status != 1 {
                            FirestoreRequests().addBarcodeToMissing(array: "missingBarcode", barcode: camModel.scannedBarcode)
                        }
                        if let uid = userViewModel.user.uid {
                            if uid != "" {
                                if !(userViewModel.user.productsViewed!.contains(camModel.scannedBarcode)) {
                                    userViewModel.user.productsScanned = userViewModel.user.productsScanned! + 1
                                    userViewModel.user.productsViewed?.append(camModel.scannedBarcode)
                                }
                                
                            }
                        }
                    }
                }
                else if foodViewModel.product != nil {
                    findingProduct = true
                    status = foodViewModel.status
                    product = foodViewModel.product
                    findingProduct = false
                    if let uid = userViewModel.user.uid {
                        if uid != "" {
                            if !(userViewModel.user.productsViewed!.contains((foodViewModel.product?._id)!)) {
                                userViewModel.user.productsFromSearch = userViewModel.user.productsFromSearch! + 1
                                userViewModel.user.productsViewed?.append((foodViewModel.product?._id)!)
                            }
                        }
                    }
                }
                
                
                if let uid = userViewModel.user.uid {
                    if uid != "" {
                        for icon in iconVM.searchIcons {
                            if userViewModel.user.productsFromSearch! >= icon.numNeeded {
                                if userViewModel.user.earnedAnims!.contains(icon.name) {
                                    
                                }
                                else {
                                    userViewModel.user.earnedAnims?.append(icon.name)
                                    iconEarned = icon.name
                                    NotificationCenter.default.post(name: NSNotification.showAnimAlert, object: nil)
                                }
                            }
                        }
                        for icon in iconVM.scanIcons {
                            if userViewModel.user.productsScanned! >= icon.numNeeded {
                                if userViewModel.user.earnedAnims!.contains(icon.name) {
                                    
                                }
                                else {
                                    userViewModel.user.earnedAnims?.append(icon.name)
                                    iconEarned = icon.name
                                    NotificationCenter.default.post(name: NSNotification.showAnimAlert, object: nil)
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

