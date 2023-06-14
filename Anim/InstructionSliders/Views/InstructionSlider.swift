//
//  InstructionSlider.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 1/23/23.
//

import SwiftUI

struct InstructionSlider: View {
    
    let defaults = UserDefaults.standard
    
    @State var index = 0
    
    @Binding var openedApp: Bool

    var images = ["AnimIntro", "ScanIntro", "SearchIntro", "ProfileIntro", "AnimOutro"]
    
    var body: some View {
        VStack(spacing: 20) {
            PagingView(index: $index.animation(), maxIndex: images.count - 1) {
                ForEach(self.images, id: \.self) { imageName in
                    Image(imageName)
                        .resizable()
                        .scaledToFill()
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                }
                .overlay(index == images.count - 1 ? DismissButton(openedApp: $openedApp) : nil, alignment: .bottom)
            }
        }
        .padding()
        .frame(
              minWidth: 0,
              maxWidth: .infinity,
              minHeight: 0,
              maxHeight: .infinity
            )
        .background(Color(UIColor(red: 247/255, green: 242/255, blue: 237/255, alpha: 1)))
    }
}
