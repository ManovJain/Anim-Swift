//
//  RingView.swift
//  Anim
//
//  Created by Manovski on 3/31/23.
//

import SwiftUI

struct RingView: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    @State var calPercentage = 0
    @State var drawingStroke = false;
    var color = Color("AnimGreen")
    
    let strawberry = Color(#colorLiteral(red: 1, green: 0.1857388616, blue: 0.5733950138, alpha: 1))
    
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
                    .stroke(color.gradient,
                            style: StrokeStyle(lineWidth: 16, lineCap: .round))
            }
            .rotationEffect(.degrees(-90))
            .onAppear(){
                calPercentage = userViewModel.nutrition.calories! / userViewModel.nutrition.totalCalories!
                drawingStroke.toggle()
            }
            .frame(width: 80)
            .animation(animation, value: drawingStroke)
    }
}
