//
//  ProfilePage.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 11/29/22.
//

import SwiftUI

struct ProfilePage: View {
    
    @EnvironmentObject var networkRequests: NetworkRequests
    
//    @State var profileMenu: ProfileMenu
    
    @State private var icon = "user"
    @State private var anim = "bird"
    
    
    var body: some View {
        VStack {
            Text(icon)
                .frame(alignment: .center)
                .font(.system(size: 30))
                .fontWeight(.bold)
            Spacer()
                .frame(height: 60)
            HStack{
                Spacer()
                Button(action: {
                    icon = "user"
                }) {
                    if icon == "user" {
                        Image(systemName: "person.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.indigo)
                    }
                    else {
                        Image(systemName: "person")
                            .font(.system(size: 20))
                            .foregroundColor(.primary)
                    }
                }
                Spacer()
                
                Button(action: {
                    icon = "anim"
                }) {
                    if icon == "anim" {
                        Image(systemName: anim + ".fill")
                            .font(.system(size: 20))
                            .foregroundColor(.indigo)
                    }
                    else {
                        Image(systemName: anim)
                            .font(.system(size: 20))
                            .foregroundColor(.primary)
                    }
                }
                Spacer()
                
                Button(action: {
                    icon = "star"
                }) {
                    if icon == "star" {
                        Image(systemName: "star.fill")
                            .font(.system(size: 20))
                            .foregroundColor(.indigo)
                            
                    }
                    else {
                        Image(systemName: "star")
                            .font(.system(size: 20))
                            .foregroundColor(.primary)
                    }
                }
                Spacer()
                
                Button(action: {
                    icon = "settings"
                }) {
                    if icon == "settings" {
                        Image(systemName: "gear")
                            .font(.system(size: 20))
                            .foregroundColor(.indigo)
                            
                    }
                    else {
                        Image(systemName: "gear")
                            .font(.system(size: 20))
                            .foregroundColor(.primary)
                    }
                }
            }
            .frame(width: 240,height: 40)
            .background(Color(.lightGray).opacity(0.75))
            .clipShape(Capsule())
            .padding(.vertical)
//                    .position(x: 10, y: 150)
            //DYNAMIC CONTENT
            if icon == "user" {
                User()
            }
            else if icon == "anim" {
                AnimManager()
            }
            else if icon == "star" {
                VStack{
                    ButtonScroll()
                    Favorites()
                }
            }
            else {
                SignUpPage()
            }
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
        ProfilePage()
    }
}
