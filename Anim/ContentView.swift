//
//  ContentView.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 11/29/22.
//

import SwiftUI
import Firebase

struct ContentView: View {
    
    @EnvironmentObject var navModel: NavModel
    @EnvironmentObject var camModel: CameraViewModel
    
    @State var openedApp: Bool = false
    
    @State var users = [UserModel]()
    
    let defaults = UserDefaults.standard
    
    var body: some View {
        
        ZStack {
            switch navModel.currentPage {
            case .camera:
                CameraView()
                    .gesture(DragGesture()
                        .onEnded { value in
                            let direction = detectDirection(value: value)
                            if direction == .left {
                                navModel.currentPage.previous()
                            }
                            if direction == .right {
                                navModel.currentPage.next()
                            }
                        }
                    )
            case .food:
                ProductPage()
                    .gesture(DragGesture()
                        .onEnded { value in
                            let direction = detectDirection(value: value)
                            if direction == .left {
                                navModel.currentPage.previous()
                            }
                            if direction == .right {
                                navModel.currentPage.next()
                            }
                        }
                    )
            case .explore:
                SearchPage()
                    .gesture(DragGesture()
                        .onEnded { value in
                            let direction = detectDirection(value: value)
                            if direction == .left {
                                navModel.currentPage.previous()
                            }
                            if direction == .right {
                                navModel.currentPage.next()
                            }
                        }
                    )
            case .profile:
                ProfilePage(profileMenu: ProfileMenu(), user: UserViewModel())
                    .gesture(DragGesture()
                        .onEnded { value in
                            let direction = detectDirection(value: value)
                            if direction == .left {
                                navModel.currentPage.previous()
                            }
                            if direction == .right {
                                navModel.currentPage.next()
                            }
                        }
                    )
            }
        }
        .overlay(openedApp ? nil : InstructionSlider(openedApp: $openedApp), alignment: .center)
        .overlay(openedApp ? PillTabBar() : nil, alignment: .bottom)
        
        .onAppear {
            openedApp = defaults.bool(forKey: "openedApp")
//
//            firestoreRequests.getUser("AybUfF54p9uDIxjckAib") { data in
//                print(data)
//            }
            
        }
    }
}

