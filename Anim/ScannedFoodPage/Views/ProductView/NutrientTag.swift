//
//  NutrientTag.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 12/7/22.
//

import SwiftUI

struct NutrientTag: View {
    
    @EnvironmentObject var foodViewModel: FoodViewModel
    
    
    var nutrient: String
    var level: String
    
    @Binding var tagAlertShown: Bool

    var body: some View {
            Button {
                changeSelectedTag()
            } label: {
                VStack {
                    Text(nutrient)
                        .font(Font.custom("DMSans-Medium", size: 15))
                        .multilineTextAlignment(.center)
                        .foregroundColor(.primary)
                }
                .frame(width: (UIScreen.screenWidth - 50)/4, height: (UIScreen.screenWidth - 50)/4)
                .background(getColor(level: level))
                .cornerRadius(15)
            }
    }
    
    func changeSelectedTag() {
        tagAlertShown = true
        foodViewModel.currentTagLevel = level
        if nutrient == "Fat" {
            foodViewModel.currentTagSelected = .fat
        }
        else if nutrient == "Salt" {
            foodViewModel.currentTagSelected = .salt
        }
        else if nutrient == "Saturated Fat" {
            foodViewModel.currentTagSelected = .saturatedFat
        }
        else if nutrient == "Sugar" {
            foodViewModel.currentTagSelected = .sugar
        }
    }
    
    
    func getColor(level: String) -> Color {
        if level == "moderate" {
            return Color.orange
        }
        else if level == "low" {
            return Color(UIColor(red: 155/255, green: 242/255, blue: 114/255, alpha: 1))
        }
        else {
            return Color.red
        }
    }
}
