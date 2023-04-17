//
//  CameraViewModel.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 11/29/22.
//

import Foundation
import SwiftUI
import AVKit
import VisionKit

enum ScanType {
    case barcode, text
}

enum DataScannerAccessStatusType {
    case unknown
    case accessDenied
    case cameraUnavailable
    case scannerAvailable
    case scannerUnavailable
}

@MainActor
final class CameraViewModel: ObservableObject {
    
    @Published var dataScannerAccessStatus: DataScannerAccessStatusType = .unknown
    @Published var recognizedItems: [RecognizedItem] = []
    @Published var scanType: ScanType = .barcode
    @Published var textContentType: DataScannerViewController.TextContentType?
    @Published var recognizesMultipleItems = false
    @Published var scannedBarcode: String = "No Barcode Scanned Yet"
    @Published var searchedBarcode: String = "No Barcode Scanned Yet"
    @Published var addingToFridge = false
    @Published var foundFridgeProduct = false
    @Published var notFoundFridgeProduct = false
    @Published var productInFridge = false
    
    var recognizedDataType: DataScannerViewController.RecognizedDataType {
        scanType == .barcode ? .barcode() : .text(textContentType: textContentType)
    }
    
    private var isScannerAvailable: Bool {
        DataScannerViewController.isAvailable && DataScannerViewController.isSupported
    }
    
    func requestDataScannerAccessStatus() async {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            dataScannerAccessStatus = .cameraUnavailable
            return
        }
        
        switch AVCaptureDevice.authorizationStatus(for: .video) {
            
        case .authorized:
            dataScannerAccessStatus = isScannerAvailable ? .scannerAvailable : .scannerUnavailable
            
        case .restricted, .denied:
            dataScannerAccessStatus = .accessDenied
            
        case .notDetermined:
            let granted = await AVCaptureDevice.requestAccess(for: .video)
            if granted {
                dataScannerAccessStatus = isScannerAvailable ? .scannerAvailable : .scannerUnavailable
            }
            else {
                dataScannerAccessStatus = .accessDenied
            }
        }
        
        
    }
    
}
