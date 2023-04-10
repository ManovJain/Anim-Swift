//
//  GradeAlertView.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 1/27/23.
//

import SwiftUI

struct GradeAlertView: View {
    
    @EnvironmentObject var foodViewModel: FoodViewModel
    
    @Binding var gradeAlertShown: Bool
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.01).edgesIgnoringSafeArea(.all)
                .frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight)
                .onTapGesture {
                    gradeAlertShown = false
                }
            VStack {
                if (foodViewModel.currentGradeSelected == "a" || foodViewModel.currentGradeSelected == "e") {
                    Text("This product has an \(foodViewModel.currentGradeSelected.capitalized) grade. This grade is based on the FSA nutritional score created by the Food Standars Agency in the UK.")
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .font(Font.custom("DMSans-Medium", size: 15))
                        .padding()
                }
                else {
                    Text("This product has a \(foodViewModel.currentGradeSelected.capitalized) grade. This grade is based on the FSA nutritional score created by the Food Standars Agency in the UK.")
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                        .font(Font.custom("DMSans-Medium", size: 15))
                        .padding()
                }
                Button {
                    gradeAlertShown = false
                } label: {
                    Text("OK")
                        .padding(4)
                }
            }
            .frame(width: UIScreen.screenWidth - 100, height: UIScreen.screenHeight / 4.5)
            .background(.white)
            .cornerRadius(30)
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(borderColor, lineWidth: 3)
            )
        }
    }
    
    var borderColor: Color {
        if foodViewModel.currentGradeSelected == "a" {
            return Color(UIColor(red: 155/255, green: 242/255, blue: 114/255, alpha: 1))
        }
        else if foodViewModel.currentGradeSelected == "b"{
            return .yellow
        }
        else if foodViewModel.currentGradeSelected == "c"{
            return .yellow
        }
        else {
            return .red
        }
    }
}

