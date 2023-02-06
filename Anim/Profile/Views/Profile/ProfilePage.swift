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
    
    
    var body: some View {
        VStack{
            Text(profileMenuViewModel.icon.rawValue)
                .frame(alignment: .center)
                .font(.system(size: 30))
                .fontWeight(.bold)
//            if(user.state == .signedIn){
                switch profileMenuViewModel.icon.rawValue {
                case "user":
                    User()
                case "Anim Manager":
                    AnimManager()
                case "favorites":
                    VStack{
                        ButtonScroll()
                        Favorites()
                    }
                default:
                    LoginPage()                }
//            }
//            else{
//                LoginPage()
//            }
        }
        .overlay(((userViewModel.state ==  .signedIn) ? ProfileMenu(): nil)
            .position(x: UIScreen.screenWidth/1.15, y:UIScreen.screenHeight/2.7)
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

struct ProfilePage_Previews: PreviewProvider {
    static var previews: some View {
        ProfilePage()
    }
}
