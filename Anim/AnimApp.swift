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
    
    init() {
        FirebaseApp.configure()
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
