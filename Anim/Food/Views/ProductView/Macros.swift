//
//  Macros.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 12/7/22.
//

import SwiftUI

struct Macros: View {
    
    var nutriments: Nutriments
    
    var body: some View {
        VStack (){
            HStack (spacing: 10){
                Spacer()
                VStack {
                    Text("\(nutriments.energy_kcal_serving ?? 0, specifier: "%.1f")")
                        .font(Font.custom("DMSans-Medium", size: 20))
                    Text("calories")
                        .font(Font.custom("DMSans-Medium", size: 20))
                }
                Divider()
                VStack {
                    Text("\(nutriments.proteins_serving ?? 0, specifier: "%.1f") \(nutriments.proteins_unit ?? "g")")
                        .font(Font.custom("DMSans-Medium", size: 20))
                    Text("protein")
                        .font(Font.custom("DMSans-Medium", size: 20))
                }
                Divider()
                VStack {
                    Text("\(nutriments.fat_serving ?? 0, specifier: "%.1f") \(nutriments.fat_unit ?? "g")")
                        .font(Font.custom("DMSans-Medium", size: 20))
                    Text("fat")
                        .font(Font.custom("DMSans-Medium", size: 20))
                }
                Divider()
                VStack {
                    Text("\(nutriments.carbohydrates_serving ?? 0, specifier: "%.1f") \(nutriments.carbohydrates_unit ?? "g")")
                        .font(Font.custom("DMSans-Medium", size: 20))
                    Text("carbs")
                        .font(Font.custom("DMSans-Medium", size: 20))
                }
                Spacer()
            }
            .frame(height: 40)
        }
    }
}
