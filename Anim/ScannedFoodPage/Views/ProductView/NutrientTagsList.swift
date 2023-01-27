//
//  NutrientTags.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 12/7/22.
//

import SwiftUI

struct NutrientTagsList: View {
    
    var nutrientLevels: NutrientLevels
    
    @Binding var tagAlertShown: Bool
    
    var body: some View {
        HStack {
            if let fat = nutrientLevels.fat {
                NutrientTag(nutrient: "Fat", level: fat, tagAlertShown: $tagAlertShown)
            }
            if let salt = nutrientLevels.salt {
                NutrientTag(nutrient: "Salt", level: salt, tagAlertShown: $tagAlertShown)
            }
            if let sfat = nutrientLevels.saturatedFat {
                NutrientTag(nutrient: "Saturated Fat", level: sfat, tagAlertShown: $tagAlertShown)
            }
            if let sugar = nutrientLevels.sugars {
                NutrientTag(nutrient: "Sugar", level: sugar, tagAlertShown: $tagAlertShown)
            }
        }
        .padding(.top)
    }
}
