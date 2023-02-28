//
//  Grade.swift
//  Anim
//
//  Created by Manovski on 2/26/23.
//

import SwiftUI


struct Grade: View {
    
    var grade: String
    var noColor: Bool
    
    
    var body: some View {
        Text(grade.capitalized)
            .font(Font.custom("DMSans-Medium", size: 12))
            .padding(10)
            .background(getColor(grade: grade))
            .clipShape(Circle())
            .foregroundColor(.primary)
    }
    
    func getColor(grade: String) -> Color {
        if noColor == true {
            return Color.white
        }
        else if grade == "C" {
            return Color.orange
        }
        else if grade == "A" {
            return Color(UIColor(red: 155/255, green: 242/255, blue: 114/255, alpha: 1))
        }
        else if grade == "B" {
            return Color.yellow
        }
        else {
            return Color.red
        }
    }
}
