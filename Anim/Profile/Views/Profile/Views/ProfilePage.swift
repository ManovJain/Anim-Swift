//
//  ProfilePage.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 11/29/22.
//

import SwiftUI

struct ProfilePage: View {
    
    @EnvironmentObject var networkRequests: NetworkRequests
    
    @EnvironmentObject var profileMenuViewModel: ProfileMenuViewModel
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    @Binding var darkMode: Bool
    
    var body: some View {
        VStack{
            switch profileMenuViewModel.icon.rawValue {
            case "settings":
                LoginPage(darkMode: $darkMode, publicAccount: userViewModel.user.isPublic ?? false)
            case "animManager":
                AnimManager()
            case "favorites":
                VStack{
                    ListsView(selection: "favorites")
                }
            default:
                ProfileView(display: "Posts")
            }
        }
        .onAppear {
            if userViewModel.state == .signedIn {
                profileMenuViewModel.icon = .user
            }
        }
        .overlay(((userViewModel.state ==  .signedIn) ? ProfileMenu(): nil)?.allowsHitTesting(true)
            .position(x: UIScreen.screenWidth/1.15, y:UIScreen.screenHeight/4.7)
        )
        .padding()
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity
        )
    }
}

