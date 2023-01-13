//
//  CameraView.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 11/29/22.
//

import SwiftUI

struct CameraView: View {
    
    @EnvironmentObject var cameraViewModel: CameraViewModel
    
    var body: some View {
        switch cameraViewModel.dataScannerAccessStatus {
        case .scannerAvailable:
            mainView
        case .cameraUnavailable:
            Text("Your device does not have a camera")
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: .infinity
                )
        case .scannerUnavailable:
            Text("You device does not support barcode scanning.")
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: .infinity
                )
        case .accessDenied:
            Text("Please provide access to the camera in Settings")
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: .infinity
                )
        case .unknown:
            Text("Requesting camera access...")
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    minHeight: 0,
                    maxHeight: .infinity
                )
        }
    }
    
    private var mainView: some View {
        DataScannerView(recognizedItems: $cameraViewModel.recognizedItems, recognizedDataType: cameraViewModel.recognizedDataType, recognizesMultipleItems: cameraViewModel.recognizesMultipleItems)
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView()
    }
}
