//
//  NutritionFacts.swift
//  Anim
//
//  Created by Brian Pattison on 6/15/23.
//

import SwiftUI

struct NutritionFacts: View {
    
    var nutriments: Nutriments
    
    @Binding var numServings: Int
    
    var body: some View {
        HStack {
            if let calories = nutriments.energy_kcal_serving {
                VStack (alignment: .leading) {
                    Text("\(Int(ceil(calories * Float(numServings))))")
                        .bold()
                        .font(Font.custom("DMSans-Medium", size: 18))
                    Text("calories")
                        .foregroundColor(.gray)
                        .font(Font.custom("DMSans-Medium", size: 16))
                }
            }
            else if let calories = nutriments.energy_kcal {
                VStack (alignment: .leading) {
                    Text("\(Int(ceil(calories)))")
                        .bold()
                        .font(Font.custom("DMSans-Medium", size: 18))
                    Text("calories")
                        .foregroundColor(.gray)
                        .font(Font.custom("DMSans-Medium", size: 16))
                }
            }
            Spacer()
            if let protein = nutriments.proteins_unit {
                VStack (alignment: .leading) {
                    if let serving = nutriments.proteins_serving {
                        Text("\(Int(ceil(serving * Float(numServings)))) \(protein)")
                            .bold()
                            .font(Font.custom("DMSans-Medium", size: 18))
                    }
                    else if let serving = nutriments.proteins_value {
                        Text("\(Int(ceil(serving * Float(numServings)))) \(protein)")
                            .bold()
                            .font(Font.custom("DMSans-Medium", size: 18))
                    }
                    Text("protein")
                        .foregroundColor(.gray)
                        .font(Font.custom("DMSans-Medium", size: 16))
                }
            }
            Spacer()
            if let fat = nutriments.fat_unit {
                VStack (alignment: .leading) {
                    if let serving = nutriments.fat_serving {
                        Text("\(Int(ceil(serving * Float(numServings)))) \(fat)")
                            .bold()
                            .font(Font.custom("DMSans-Medium", size: 18))
                    }
                    else if let serving = nutriments.fat_value {
                        Text("\(Int(ceil(serving * Float(numServings)))) \(fat)")
                            .bold()
                            .font(Font.custom("DMSans-Medium", size: 18))
                    }
                    Text("fat")
                        .foregroundColor(.gray)
                        .font(Font.custom("DMSans-Medium", size: 16))
                }
            }
            Spacer()
            if let carbs = nutriments.carbohydrates_unit {
                VStack (alignment: .leading) {
                    if let serving = nutriments.carbohydrates_serving {
                        Text("\(Int(ceil(serving * Float(numServings)))) \(carbs)")
                            .bold()
                            .font(Font.custom("DMSans-Medium", size: 18))
                    }
                    else if let serving = nutriments.carbohydrates_value {
                        Text("\(Int(ceil(serving * Float(numServings)))) \(carbs)")
                            .bold()
                            .font(Font.custom("DMSans-Medium", size: 18))
                    }
                    Text("carbohydrates")
                        .foregroundColor(.gray)
                        .font(Font.custom("DMSans-Medium", size: 16))
                }
            }
            
        }
    }
}
