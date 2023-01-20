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
        .overlay(PillTabBar(), alignment: .bottom)
    }
}

