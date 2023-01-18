//
//  AnimApp.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 11/29/22.
//

import SwiftUI
import Firebase
import FirebaseCore


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    FirebaseApp.configure()

    return true
  }
  
//    let ref = Database.database().reference()

    
}

@main
struct AnimApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    @StateObject private var cameraViewModel = CameraViewModel()
    
    @StateObject var navModel = NavModel()
    
    @StateObject var profileMenuViewModel = ProfileMenuViewModel()
    
//    @StateObject var userModel = UserModel()
    
    @StateObject var scannedFoodViewModel = ScannedFoodViewModel()
    
    var networkRequests = NetworkRequests()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(navModel)
                .environmentObject(networkRequests)
                .environmentObject(cameraViewModel)
                .environmentObject(profileMenuViewModel)
//                .environmentObject(userModel)
                .environmentObject(scannedFoodViewModel)
                .task {
                    await cameraViewModel.requestDataScannerAccessStatus()
                }
        }
    }
}
