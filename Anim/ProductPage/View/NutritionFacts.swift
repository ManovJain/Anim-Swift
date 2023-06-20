//
//  NutritionFacts.swift
//  Anim
//
//  Created by Brian Pattison on 6/15/23.
//

import SwiftUI

struct NutritionFacts: View {
    
    var nutriments: Nutriments
    
    var body: some View {
        HStack {
            if let calories = nutriments.energy_kcal_serving {
                VStack (alignment: .leading) {
                    Text("\(Int(ceil(calories)))")
                        .bold()
                        .font(.system(size: 18))
                    Text("calories")
                        .foregroundColor(.gray)
                        .font(.system(size: 16))
                }
            }
            Spacer()
            if let protein = nutriments.proteins_unit {
                VStack (alignment: .leading) {
                    Text("\(Int(ceil(nutriments.proteins_serving!))) \(protein)")
                        .bold()
                        .font(.system(size: 18))
                    Text("protein")
                        .foregroundColor(.gray)
                        .font(.system(size: 16))
                }
            }
            Spacer()
            if let fat = nutriments.fat_unit {
                VStack (alignment: .leading) {
                    Text("\(Int(ceil(nutriments.fat_serving!))) \(fat)")
                        .bold()
                        .font(.system(size: 18))
                    Text("fat")
                        .foregroundColor(.gray)
                        .font(.system(size: 16))
                }
            }
            Spacer()
            if let carbs = nutriments.carbohydrates_unit {
                VStack (alignment: .leading) {
                    Text("\(Int(ceil(nutriments.carbohydrates_serving!))) \(carbs)")
                        .bold()
                        .font(.system(size: 18))
                    Text("carbohydrates")
                        .foregroundColor(.gray)
                        .font(.system(size: 16))
                }
            }
            
        }
    }
}
