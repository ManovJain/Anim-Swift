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
            Group {
                Spacer()
                Button(action: {
                    navModel.cameraEdge = Edge.leading
                    navModel.productEdge = Edge.trailing
                    navModel.exploreEdge = Edge.trailing
                    navModel.socialEdge = Edge.trailing
                    withAnimation() {
                        navModel.currentPage = .camera
                    }
                }) {
                    if navModel.currentPage == .camera {
                        VStack {
                            Image("cameraGreen")
                                .resizable()
                                .frame(width: 23, height: 23)
                        }
                        .frame(height: 35)
                        .border(width: 2, edges: [.bottom], color: Color("AnimGreen"))
                    }
                    else {
                        Image("camera")
                            .resizable()
                            .frame(width: 23, height: 23)
                            .foregroundColor(.primary)
                    }
                }
                Spacer()
            }
            Button(action: {
                navModel.exploreEdge = Edge.trailing
                navModel.socialEdge = Edge.trailing
                withAnimation() {
                    navModel.currentPage = .food
                }
            }) {
                if navModel.currentPage == .food {
                    VStack {
                        Image("forkGreen")
                            .resizable()
                            .frame(width: 23, height: 23)
                    }
                    .frame(height: 35)
                    .border(width: 2, edges: [.bottom], color: Color("AnimGreen"))
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
                navModel.productEdge = Edge.leading
                navModel.socialEdge = Edge.trailing
                withAnimation() {
                    navModel.currentPage = .explore
                }
            }) {
                if navModel.currentPage == .explore {
                    VStack {
                        Image("searchGreen")
                            .resizable()
                            .frame(width: 23, height: 23)
                    }
                    .frame(height: 35)
                    .border(width: 2, edges: [.bottom], color: Color("AnimGreen"))
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
                navModel.productEdge = Edge.leading
                navModel.exploreEdge = Edge.leading
                withAnimation() {
                    navModel.currentPage = .social
                }
            }) {
                if navModel.currentPage == .social {
                    VStack {
                        Image("socialGreen")
                            .resizable()
                            .frame(width: 23, height: 23)
                    }
                    .frame(height: 35)
                    .border(width: 2, edges: [.bottom], color: Color("AnimGreen"))
                }
                else {
                    Image("social")
                        .resizable()
                        .frame(width: 23, height: 23)
                        .foregroundColor(.primary)
                }
            }
            
            Spacer()
            Button(action: {
                navModel.socialEdge = Edge.leading
                withAnimation() {
                    navModel.currentPage = .profile
                }
            }) {
                if navModel.currentPage == .profile {
                    VStack {
                        Image("\(userViewModel.user.anim ?? "default")Green")
                            .resizable()
                            .frame(width: 23, height: 23)
                    }
                    .frame(height: 35)
                    .border(width: 2, edges: [.bottom], color: Color("AnimGreen"))
                }
                else {
                    Image("\(userViewModel.user.anim ?? "default")")
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
