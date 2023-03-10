//
//  AlertView.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 12/8/22.
//

import SwiftUI

struct TagAlertView: View {
    
    @EnvironmentObject var foodViewModel: FoodViewModel
    
    @Binding var tagAlertShown: Bool
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.01).edgesIgnoringSafeArea(.all)
                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
                .onTapGesture {
                    tagAlertShown = false
                }
            VStack {
                Text("This product has a \(foodViewModel.currentTagLevel) \(foodViewModel.currentTagSelected.rawValue) content.")
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
                    .stroke(borderColor, lineWidth: 3)
            )
        }
    }
    
    var borderColor: Color {
        if foodViewModel.currentTagLevel == "high" {
            return .red
        }
        else if foodViewModel.currentTagLevel == "low"{
            return Color(UIColor(red: 155/255, green: 242/255, blue: 114/255, alpha: 1))
        }
        else {
            return .orange
        }
    }
}
