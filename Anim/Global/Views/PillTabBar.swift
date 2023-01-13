//
//  PillTabBar.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 11/29/22.
//

import SwiftUI

struct PillTabBar: View {
    
    @EnvironmentObject var navModel: NavModel
    
    var body: some View {
        HStack {
            Spacer()
            Button(action: {
                navModel.currentPage = .camera
            }) {
                if navModel.currentPage == .camera {
                    Image(systemName: "camera")
                        .font(.system(size: 20))
                        .frame(height: 35)
                        .foregroundColor(.green)
                        .border(width: 2, edges: [.bottom], color: .green)
                }
                else {
                    Image(systemName: "camera")
                        .font(.system(size: 20))
                        .foregroundColor(.primary)
                }
            }
            Spacer()
            Button(action: {
                navModel.currentPage = .food
            }) {
                if navModel.currentPage == .food {
                    Image(systemName: "fork.knife.circle")
                        .font(.system(size: 20))
                        .frame(height: 35)
                        .foregroundColor(.green)
                        .border(width: 2, edges: [.bottom], color: .green)
                }
                else {
                    Image(systemName: "fork.knife.circle")
                        .font(.system(size: 20))
                        .foregroundColor(.primary)
                }
            }
            Spacer()
            Button(action: {
                navModel.currentPage = .explore
            }) {
                if navModel.currentPage == .explore {
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 20))
                        .frame(height: 35)
                        .foregroundColor(.green)
                        .border(width: 2, edges: [.bottom], color: .green)
                }
                else {
                    Image(systemName: "magnifyingglass.circle")
                        .font(.system(size: 20))
                        .foregroundColor(.primary)
                }
            }
            
            Spacer()
            Button(action: {
                navModel.currentPage = .profile
            }) {
                if navModel.currentPage == .profile {
                    Image(systemName: "person")
                        .font(.system(size: 20))
                        .frame(height: 35)
                        .foregroundColor(.green)
                        .border(width: 2, edges: [.bottom], color: .green)
                }
                else {
                    Image(systemName: "person")
                        .font(.system(size: 20))
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
