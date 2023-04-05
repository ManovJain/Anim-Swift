//
//  Banner.swift
//  Anim
//
//  Created by Manovski on 4/5/23.
//

import SwiftUI

struct Banner: View {
    
    @EnvironmentObject var navModel: NavModel
    
    @State var inputImage: String
    @State var location: String
    
    var body: some View {
        Button(action: {
            navModel.exploreEdge = Edge.trailing
            withAnimation() {
                locationConvert(location: location)
            }
        }) {
            Image(inputImage)
                .resizable()
                .aspectRatio(contentMode: .fit)
        }
    }
    func locationConvert(location: String) {
        if location == "camera" {
            navModel.currentPage = .camera
        }
        else if location == "food" {
            navModel.currentPage = .food
        }
        else if location == "explore" {
            navModel.currentPage = .explore
        }
        else if location == "profile" {
            navModel.currentPage = .profile
        }
        else if location == "animManager" {
            navModel.currentPage = .animManager
        }
        else if location == "foodLog" {
            navModel.currentPage = .foodLog
        }
    }
}
