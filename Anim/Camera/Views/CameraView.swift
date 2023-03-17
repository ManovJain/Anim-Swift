//
//  CameraView.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 11/29/22.
//

import SwiftUI

struct CameraView: View {
    
    @EnvironmentObject var cameraViewModel: CameraViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    
    @State var foundFridgeProduct: Bool = false
    
    @State var notFoundFridgeProduct: Bool = false
    
    var body: some View {
        VStack {
            switch cameraViewModel.dataScannerAccessStatus {
            case .scannerAvailable:
                mainView
                    .overlay(((userViewModel.state ==  .signedIn) ? CameraMenu(): nil)
                        .position(x: UIScreen.screenWidth/1.15, y:UIScreen.screenHeight/4.7)
                        )
                    .toast(message: "Product added to fridge",
                           isShowing: $cameraViewModel.foundFridgeProduct,
                                 duration: Toast.short)
                    .toast(message: "Product not found",
                           isShowing: $cameraViewModel.notFoundFridgeProduct,
                                 duration: Toast.short)
            case .cameraUnavailable:
                Text("Your device does not have a camera")
                    .font(Font.custom("DMSans-Medium", size: 15))
                    .foregroundColor(Color("AnimGreen"))
                    .frame(
                        minWidth: 0,
                        maxWidth: .infinity,
                        minHeight: 0,
                        maxHeight: .infinity
                    )
            case .scannerUnavailable:
                Text("Your device does not support barcode scanning.")
                    .font(Font.custom("DMSans-Medium", size: 15))
                    .foregroundColor(Color("AnimGreen"))
                    .frame(
                        minWidth: 0,
                        maxWidth: .infinity,
                        minHeight: 0,
                        maxHeight: .infinity
                    )
            case .accessDenied:
                Text("Please provide access to the camera in Settings")
                    .font(Font.custom("DMSans-Medium", size: 15))
                    .foregroundColor(Color("AnimGreen"))
                    .frame(
                        minWidth: 0,
                        maxWidth: .infinity,
                        minHeight: 0,
                        maxHeight: .infinity
                    )
            case .unknown:
                Text("Requesting camera access...")
                    .font(Font.custom("DMSans-Medium", size: 15))
                    .foregroundColor(Color("AnimGreen"))
                    .frame(
                        minWidth: 0,
                        maxWidth: .infinity,
                        minHeight: 0,
                        maxHeight: .infinity
                    )
            }
        }
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity
        )
    }
    
    private var mainView: some View {
        DataScannerView(recognizedItems: $cameraViewModel.recognizedItems, recognizedDataType: cameraViewModel.recognizedDataType, recognizesMultipleItems: cameraViewModel.recognizesMultipleItems)
            .ignoresSafeArea()
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
