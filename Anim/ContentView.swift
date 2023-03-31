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
                    .gesture(DragGesture()
                        .onEnded { value in
                            let direction = detectDirection(value: value)
                            if direction == .right {
                                withAnimation {
                                    navModel.currentPage.next()
                                }
                            }
                        }
                    )
                    .transition(.move(edge: navModel.cameraEdge))
            case .food:
                ProductPage()
                    .gesture(DragGesture()
                        .onEnded { value in
                            let direction = detectDirection(value: value)
                            if direction == .left {
                                navModel.productEdge = Edge.trailing
                                withAnimation {
                                    navModel.currentPage.previous()
                                }
                            }
                            if direction == .right {
                                navModel.productEdge = Edge.leading
                                withAnimation {
                                    navModel.currentPage.next()
                                }
                            }
                        }
                    )
                    .onAppear {
                        navModel.exploreEdge = Edge.trailing
                    }
                    .transition(.move(edge: navModel.productEdge))
            case .explore:
                SearchPage()
                    .gesture(DragGesture()
                        .onEnded { value in
                            let direction = detectDirection(value: value)
                            if direction == .left {
                                navModel.exploreEdge = Edge.trailing
                                withAnimation  {
                                    navModel.currentPage.previous()
                                }
                            }
                            if direction == .right {
                                navModel.exploreEdge = Edge.leading
                                withAnimation {
                                    navModel.currentPage.next()
                                }
                            }
                        }
                    )
                    .transition(.move(edge: navModel.exploreEdge))
            case .profile:
                ProfilePage(darkMode: $darkMode)
                    .gesture(DragGesture()
                        .onEnded { value in
                            let direction = detectDirection(value: value)
                            if direction == .left {
                                withAnimation  {
                                    navModel.currentPage.previous()
                                }
                            }
                        }
                    )
                    .transition(.move(edge: navModel.profileEdge))
            }
        }
        .background(Color("background"))
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .background {
                fireStoreRequests.updateUser(uid: userViewModel.user.uid!, user: userViewModel.user)
            }
        }
        .overlay(openedApp ? nil : InstructionSlider(openedApp: $openedApp), alignment: .center)
        .overlay(openedApp ? PillTabBar() : nil, alignment: .bottom)
        
        .preferredColorScheme(darkMode ? .dark : .light)
        
        .onAppear {
            
            openedApp = defaults.bool(forKey: "openedApp")
            
            userViewModel.user.anim = defaults.string(forKey: "anim")
            
            //get user stored in default user if signedIn before is true
            
            if defaults.bool(forKey: "signedIn") {
                if defaults.string(forKey: "uid") != nil {
                    fireStoreRequests.getUser(defaults.string(forKey: "uid")!) { data in
                        userViewModel.user = data!
                        userViewModel.state = .signedIn
                    }
                }
            }
        }
    }
}

