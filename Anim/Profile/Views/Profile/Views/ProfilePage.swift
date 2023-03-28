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
            case "user":
                UserView(display: "info")
//                FoodLogView()
            case "Anim Manager":
                AnimManager()
            case "favorites":
                VStack{
                    ListsView(selection: "favorites")
                }
            default:
                LoginPage(darkMode: $darkMode)
            }
        }
        .overlay(((userViewModel.state ==  .signedIn) ? ProfileMenu(): nil)
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

