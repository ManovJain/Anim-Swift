//
//  DataScannerView.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 11/29/22.
//

import Foundation
import SwiftUI
import VisionKit

struct DataScannerView: UIViewControllerRepresentable {
    
    @Binding var recognizedItems: [RecognizedItem]
    
    @EnvironmentObject var navModel: NavModel
    @EnvironmentObject var cameraViewModel: CameraViewModel
    
    let recognizedDataType: DataScannerViewController.RecognizedDataType
    let recognizesMultipleItems: Bool
    
    func makeUIViewController(context: Context) -> some DataScannerViewController {
        let vc = DataScannerViewController (
            recognizedDataTypes: [recognizedDataType],
            qualityLevel: .balanced,
            recognizesMultipleItems: recognizesMultipleItems,
            isGuidanceEnabled: true,
            isHighlightingEnabled: true
        )
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        uiViewController.delegate = context.coordinator
        try? uiViewController.startScanning()
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(recognizedItems: $recognizedItems, navModel: navModel, camModel: cameraViewModel)
    }
    
    class Coordinator: NSObject, DataScannerViewControllerDelegate, ObservableObject {
        
        @Binding var recognizedItems: [RecognizedItem]
        
        @Published var barcode: String
        @Published var currentPage: CurrentPageNav
        
        private var navModel: NavModel
        private var camModel: CameraViewModel
        
        init(recognizedItems: Binding<[RecognizedItem]>, navModel: NavModel, camModel: CameraViewModel) {
            _currentPage = .init(initialValue: navModel.currentPage)
            _barcode = .init(initialValue: camModel.scannedBarcode)
            self._recognizedItems = recognizedItems
            self.navModel = navModel
            self.camModel = camModel
        }

        func dataScanner(_ dataScanner: DataScannerViewController, didTapOn item: RecognizedItem) {
            print("didTapOn \(item)")
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, didAdd addedItems: [RecognizedItem], allItems: [RecognizedItem]) {
            UINotificationFeedbackGenerator().notificationOccurred(.success)
            recognizedItems.append(contentsOf: addedItems)
            
            for item in recognizedItems {
                switch item {
                case .barcode(let barcode) :
                    camModel.scannedBarcode = barcode.payloadStringValue ?? "Unknown"
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
                        navModel.currentPage = .food
                    }
                case .text(let text) :
                    camModel.scannedBarcode = text.transcript ?? "Unknown"
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [self] in
                        navModel.currentPage = .food
                    }
                }
            }
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, didRemove removedItems: [RecognizedItem], allItems: [RecognizedItem]) {
            self.recognizedItems = recognizedItems.filter { item in
                !removedItems.contains(where: {$0.id == item.id})
            }
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, becameUnavailableWithError error: DataScannerViewController.ScanningUnavailable) {
            print("error \(error)")
        }
    }
    
}
