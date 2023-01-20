//
//  AlertView.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 12/8/22.
//

import SwiftUI

struct AlertView: View {
    
    @EnvironmentObject var foodViewModel: FoodViewModel
    
    @Binding var alertShown: Bool
    
    var body: some View {
        ZStack {
            Color.black.opacity(0).edgesIgnoringSafeArea(.all)
                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
                .onTapGesture {
                    alertShown = false
                }
            VStack {
                Text("This product has a \(foodViewModel.currentTagLevel) \(foodViewModel.currentTagSelected.rawValue) content.")
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
                    .bold()
                    .padding()
                Button {
                    alertShown = false
                } label: {
                    Text("OK")
                }
            }
            .frame(width: UIScreen.screenWidth - 100, height: UIScreen.screenHeight / 6)
            .background(.white)
            .cornerRadius(30)
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(borderColor, lineWidth: 4)
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
