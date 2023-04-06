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
        if(FirebaseApp.app() == nil){
            FirebaseApp.configure()
        }
    }
    
    @StateObject private var cameraViewModel = CameraViewModel()
    
    @StateObject var navModel = NavModel()
    
    @StateObject var profileMenuViewModel = ProfileMenuViewModel()
    
    @StateObject var userViewModel = UserViewModel()
    
    @StateObject var foodViewModel = FoodViewModel()
    
    @StateObject var exploreViewModel = ExploreViewModel()
    
    @StateObject var networkRequests = NetworkRequests()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(navModel)
                .environmentObject(networkRequests)
                .environmentObject(cameraViewModel)
                .environmentObject(profileMenuViewModel)
                .environmentObject(userViewModel)
                .environmentObject(foodViewModel)
                .environmentObject(exploreViewModel)
                .task {
                    await cameraViewModel.requestDataScannerAccessStatus()
                }
        }
    }
}
