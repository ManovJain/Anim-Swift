//
//  ExploreToggle.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 4/3/23.
//

import SwiftUI

struct ExploreToggle: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    @EnvironmentObject var exploreViewModel: ExploreViewModel
    
    @Binding var missingUsername : Bool
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                exploreViewModel.feedType = .explore
            }) {
                if exploreViewModel.feedType == .explore {
                    Text("Explore")
                        .foregroundColor(Color("background"))
                        .font(Font.custom("DMSans-Medium", size: 14))
                        .padding(.bottom, 5)
                        .border(width: 2, edges: [.bottom], color: Color("background"))
                }
                else {
                    Text("Explore")
                        .foregroundColor(Color("background"))
                        .font(Font.custom("DMSans-Medium", size: 14))
                        .padding(.bottom, 5)
                }
            }
            if userViewModel.state == .signedIn {
                Spacer()
                Button(action: {
                    if !userViewModel.user.hasSetUsername! {
                        missingUsername.toggle()
                    }
                    else {
                        exploreViewModel.feedType = .following
                    }
                }) {
                    if exploreViewModel.feedType == .following {
                        Text("Following")
                            .foregroundColor(Color("background"))
                            .font(Font.custom("DMSans-Medium", size: 14))
                            .padding(.bottom, 5)
                            .border(width: 2, edges: [.bottom], color: Color("background"))
                    }
                    else {
                        Text("Following")
                            .foregroundColor(Color("background"))
                            .font(Font.custom("DMSans-Medium", size: 14))
                            .padding(.bottom, 5)
                    }
                }
            }
            Spacer()
        }
        .frame(height: 50)
        .background(Color("AnimGreen"))
    }
}
