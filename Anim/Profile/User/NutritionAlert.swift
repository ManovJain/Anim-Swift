//
//  AlertView.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 12/8/22.
//

import SwiftUI

struct NutritionAlert: View {
    
    @Binding var tagAlertShown: Bool
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.01).edgesIgnoringSafeArea(.all)
                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
                .onTapGesture {
                    tagAlertShown = false
                }
            VStack {
                Text("Nutrition is in beta, calories & macros will reset at midnight CST everday.")
                    .font(Font.custom("DMSans-Medium", size: 15))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .bold()
                    .padding()
                Button {
                    tagAlertShown = false
                } label: {
                    Text("OK")
                        .font(Font.custom("DMSans-Medium", size: 15))
                }
            }
            .frame(width: UIScreen.screenWidth - 100, height: UIScreen.screenHeight / 6)
            .background(.white)
            .cornerRadius(30)
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(Color("AnimGreen"), lineWidth: 3)
            )
        }
    }
}
