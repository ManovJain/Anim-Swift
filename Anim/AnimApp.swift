//
//  AnimApp.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 11/29/22.
//

import SwiftUI
import Firebase
import FirebaseCore
import GoogleSignIn
import FirebaseAuth


@main
struct AnimApp: App {
    
    //calling delegate...
    @UIApplicationDelegateAdaptor(AppDelegate.self) var
        delegate
    
    init() {
        if(FirebaseApp.app() == nil){
            FirebaseApp.configure()
        }
        setupAuthentication()
    }
    
    @StateObject private var cameraViewModel = CameraViewModel()
    
    @StateObject var navModel = NavModel()
    
    @StateObject var profileMenuViewModel = ProfileMenuViewModel()
    
    @StateObject var userViewModel = UserViewModel()
    
    @StateObject var foodViewModel = FoodViewModel()
    
    var networkRequests = NetworkRequests()
    
    var firestoreRequests = FirestoreRequests()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(navModel)
                .environmentObject(networkRequests)
                .environmentObject(firestoreRequests)
                .environmentObject(cameraViewModel)
                .environmentObject(profileMenuViewModel)
                .environmentObject(userViewModel)
                .environmentObject(foodViewModel)
                .task {
                    await cameraViewModel.requestDataScannerAccessStatus()
                }
        }
    }
}

extension AnimApp {
  private func setupAuthentication() {
      if(FirebaseApp.app() == nil){
          FirebaseApp.configure()
      }
  }
}

//initializing firebase

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions:
        [UIApplication.LaunchOptionsKey : Any]? = nil) ->
        Bool {
//            FirebaseApp.configure()
            return true
    }
}
