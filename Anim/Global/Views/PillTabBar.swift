//
//  PillTabBar.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 11/29/22.
//

import SwiftUI

struct PillTabBar: View {
    
    @EnvironmentObject var navModel: NavModel
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                navModel.currentPage = .camera
            }) {
                if navModel.currentPage == .camera {
                    VStack {
                        Image("cameraGreen")
                            .resizable()
                            .frame(width: 23, height: 23)
                    }
                    .frame(height: 35)
                    .border(width: 2, edges: [.bottom], color: .green)
                }
                else {
                    Image("camera")
                        .resizable()
                        .frame(width: 23, height: 23)
                        .foregroundColor(.primary)
                }
            }
            Spacer()
            Button(action: {
                navModel.currentPage = .food
            }) {
                if navModel.currentPage == .food {
                    VStack {
                        Image("forkGreen")
                            .resizable()
                            .frame(width: 23, height: 23)
                    }
                    .frame(height: 35)
                    .border(width: 2, edges: [.bottom], color: .green)
                }
                else {
                    Image("fork")
                        .resizable()
                        .frame(width: 23, height: 23)
                        .foregroundColor(.primary)
                }
            }
            Spacer()
            Button(action: {
                navModel.currentPage = .explore
            }) {
                if navModel.currentPage == .explore {
                    VStack {
                        Image("searchGreen")
                            .resizable()
                            .frame(width: 23, height: 23)
                    }
                    .frame(height: 35)
                    .border(width: 2, edges: [.bottom], color: .green)
                }
                else {
                    Image("search")
                        .resizable()
                        .frame(width: 23, height: 23)
                        .foregroundColor(.primary)
                }
            }
            
            Spacer()
            Button(action: {
                navModel.currentPage = .profile
            }) {
                if navModel.currentPage == .profile {
                    VStack {
                        Image("\(userViewModel.userModel.anim ?? "default")Green")
                            .resizable()
                            .frame(width: 23, height: 23)
                    }
                    .frame(height: 35)
                    .border(width: 2, edges: [.bottom], color: .green)
                }
                else {
                    Image("\(userViewModel.userModel.anim ?? "default")")
                        .resizable()
                        .frame(width: 23, height: 23)
                        .foregroundColor(.primary)
                }
            }
            Spacer()
        }
        .frame(width: 200,height: 40)
        .background(Color(.lightGray).opacity(0.75))
        .clipShape(Capsule())
        .padding(.bottom)
    }
}

struct PillTabBar_Previews: PreviewProvider {
    static var previews: some View {
        PillTabBar()
    }
}
