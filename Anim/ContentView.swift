//
//  ContentView.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 11/29/22.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    @Environment(\.scenePhase) var scenePhase
    
    @EnvironmentObject var navModel: NavModel
    @EnvironmentObject var camModel: CameraViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    
    @AppStorage("darkMode") var darkMode = false
    
    var fireStoreRequests = FirestoreRequests()
    
    @State var openedApp: Bool = false
    
    let defaults = UserDefaults.standard
    
    var body: some View {
        
        ZStack {
            switch navModel.currentPage {
            case .camera:
                CameraView()
                    .edgesIgnoringSafeArea(.all)
            case .food:
                FoodPage()
                    .edgesIgnoringSafeArea(.all)
            case .explore:
//                SearchPage()
                Search2()
                
            case .social:
                ExplorePage()
                
            case .profile:
                ProfilePage(darkMode: $darkMode)
            case .animManager:
                AnimManager()
            case .foodLog:
            FoodLogView()
            }
            if openedApp {
                PillTabBar()
                    .position(x: UIScreen.screenWidth/2, y: UIScreen.screenHeight - 50)
            }
        }
        .background(Color("background"))
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .background {
                fireStoreRequests.updateUser(uid: userViewModel.user.uid!, user: userViewModel.user)
                fireStoreRequests.updateNutrition(uid: userViewModel.user.uid!, nutrition: userViewModel.nutrition)
            }
        }
        .overlay(openedApp ? nil : InstructionSlider(openedApp: $openedApp), alignment: .center)
        
        .preferredColorScheme(darkMode ? .dark : .light)
        
        .onAppear {

            openedApp = defaults.bool(forKey: "openedApp")
            
            userViewModel.user.anim = defaults.string(forKey: "anim")

            //get user stored in default user if signedIn before is true

            if defaults.bool(forKey: "signedIn") {
                if defaults.string(forKey: "uid") != nil {
                    fireStoreRequests.getUser(defaults.string(forKey: "uid")!) { data in
                        userViewModel.user = data!
                        fireStoreRequests.getNutrition(defaults.string(forKey: "uid")!) { data in
                            userViewModel.nutrition = data!
                            userViewModel.state = .signedIn
                        }
                    }
                }
            }
        }
    }
}

