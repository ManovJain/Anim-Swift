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
    
    @State var profileMenu: ProfileMenu
    
    @State private var anim = "bird"
    
    
    var body: some View {
        VStack{
            Text(profileMenuViewModel.icon.rawValue)
                .frame(alignment: .center)
                .font(.system(size: 30))
                .fontWeight(.bold)
            HStack {
                //DYNAMIC CONTENT
                if profileMenuViewModel.icon.rawValue == "user" {
                    User()
                }
                else if profileMenuViewModel.icon.rawValue == "animManager" {
                    AnimManager()
                }
                else if profileMenuViewModel.icon.rawValue == "favorites" {
                    VStack{
                        ButtonScroll()
                        Favorites()
                    }
                }
                else {
                    SignUpPage()
                }
                profileMenu
            }
            .position(x: UIScreen.screenWidth/2.3, y:UIScreen.screenHeight/3.5)
        }
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
        ProfilePage(profileMenu: ProfileMenu())
    }
}
