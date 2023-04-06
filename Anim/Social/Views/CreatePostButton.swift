//
//  CreatePostButton.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 4/5/23.
//

import SwiftUI

struct CreatePostButton: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    @Binding var missingUsername : Bool
    
    var body: some View {
        if !userViewModel.user.hasSetUsername! {
            Button(action: {
                missingUsername.toggle()
            }){
                ZStack {
                    Circle()
                        .frame(width: 50, height: 50)
                        .foregroundColor(Color("AnimGreen"))
                    Image(systemName: "plus")
                        .resizable()
                        .foregroundColor(Color("background"))
                        .frame(width: 20, height: 20)
                }
            }
        }
        else {
            NavigationLink(destination: CreatePostView()) {
                ZStack {
                    Circle()
                        .frame(width: 50, height: 50)
                        .foregroundColor(Color("AnimGreen"))
                    Image(systemName: "plus")
                        .resizable()
                        .foregroundColor(Color("background"))
                        .frame(width: 20, height: 20)
                }
            }
        }
    }
}
