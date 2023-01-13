//
//  NutrientTags.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 12/7/22.
//

import SwiftUI

struct NutrientTagsList: View {
    
    var nutrientLevels: NutrientLevels
    
    var fromSearch: Bool
    
    @Binding var alertShown: Bool
    
    var body: some View {
        HStack {
            if let fat = nutrientLevels.fat {
                NutrientTag(nutrient: "Fat", level: fat, fromSearch: fromSearch, alertShown: $alertShown)
            }
            if let salt = nutrientLevels.salt {
                NutrientTag(nutrient: "Salt", level: salt, fromSearch: fromSearch, alertShown: $alertShown)
            }
            if let sfat = nutrientLevels.saturatedFat {
                NutrientTag(nutrient: "Saturated Fat", level: sfat, fromSearch: fromSearch, alertShown: $alertShown)
            }
            if let sugar = nutrientLevels.sugars {
                NutrientTag(nutrient: "Sugar", level: sugar, fromSearch: fromSearch, alertShown: $alertShown)
            }
        }
        .padding(.top)
    }
}
