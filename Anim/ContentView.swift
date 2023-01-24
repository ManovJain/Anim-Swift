//
//  ContentView.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 11/29/22.
//

import SwiftUI

struct ContentView: View {
    
    @EnvironmentObject var navModel: NavModel
    @EnvironmentObject var camModel: CameraViewModel
    
    @State var openedApp: Bool = false
    
    let defaults = UserDefaults.standard

    var body: some View {
        
        ZStack {
            switch navModel.currentPage {
            case .camera:
                CameraView()
            case .food:
                ProductPage()
            case .explore:
                SearchPage()
            case .profile:
                ProfilePage(profileMenu: ProfileMenu())
            }
        }
        .overlay(openedApp ? nil : InstructionSlider(openedApp: $openedApp), alignment: .center)
        .overlay(openedApp ? PillTabBar() : nil, alignment: .bottom)
        
        .onAppear {
            openedApp = defaults.bool(forKey: "openedApp")

        }
    }
}

