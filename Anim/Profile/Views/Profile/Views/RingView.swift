//
//  RingView.swift
//  Anim
//
//  Created by Manovski on 3/31/23.
//

import SwiftUI

struct RingView: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    @State var calPercentage = 0.0
    @State var drawingStroke = false;
    var color = Color("AnimGreen")
    
    let animation = Animation
        .easeOut(duration: 3)
        .delay(0.5)
    
    var body: some View {
        Circle()
            .stroke(style: StrokeStyle(lineWidth: 16))
            .foregroundStyle(.tertiary)
            .overlay {
                // Foreground ring
                Circle()
                    .trim(from: 0, to: drawingStroke ? CGFloat(calPercentage) : 0)
                //                    .trim(from: 0, to: drawingStroke ? 0.5 : 0)
                    .stroke(color.gradient,
                            style: StrokeStyle(lineWidth: 16, lineCap: .round))
            }
            .rotationEffect(.degrees(-90))
            .onAppear(){
                calPercentage = Double(userViewModel.nutrition.calories!)/Double(userViewModel.nutrition.totalCalories!)
                drawingStroke.toggle()
            }
            .frame(width: 80)
            .animation(animation, value: drawingStroke)
    }
}

//struct RingView_Previews: PreviewProvider {
//    static var previews: some View {
//        RingView()
//    }
//}
