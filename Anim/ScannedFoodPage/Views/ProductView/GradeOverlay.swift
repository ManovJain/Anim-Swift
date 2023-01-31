//
//  GradeOverlay.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 12/6/22.
//

import SwiftUI


struct GradeOverlay: View {
    
    @EnvironmentObject var foodViewModel: FoodViewModel
    
    var grade: String
    
    @Binding var gradeAlertShown: Bool
    
    
    var body: some View {
        if grade != "NA" {
        
        Button {
            foodViewModel.currentGradeSelected = grade
            gradeAlertShown = true
        } label: {
            ZStack {
                Text(grade.capitalized)
                    .font(.system(size: 30))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .bold()
                    .padding(5)
                    .background(getColor(grade: grade))
                    .clipShape(Circle())
            }
            .padding(.horizontal, 5)}
        }
    }
    
    func getColor(grade: String) -> Color {
        if grade == "c" {
            return Color.orange
        }
        else if grade == "a" {
            return Color(UIColor(red: 155/255, green: 242/255, blue: 114/255, alpha: 1))
        }
        else if grade == "b" {
            return Color.yellow
        }
        else {
            return Color.red
        }
    }
}
