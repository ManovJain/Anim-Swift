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
                }
            }
            Button {
                defaults.set(true, forKey: "openedApp")
                openedApp = true
            }
        label: {
            Text("Dismiss")
        }
            //            .aspectRatio(contentMode: .fill)
        .clipShape(RoundedRectangle(cornerRadius: 15))
        }
        .padding()
        
    }
}
