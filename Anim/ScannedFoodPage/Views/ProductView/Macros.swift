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
        VStack (alignment: .leading, spacing: 0){
            Text("Macros")
                .underline()
                .font(Font.custom("DMSans-Medium", size: 17))
            HStack (alignment: .top){
                Text("\(nutriments.proteins_serving ?? 0, specifier: "%.1f") \(nutriments.proteins_unit ?? "g") protein")
                    .font(Font.custom("DMSans-Medium", size: 15))
                Divider()
                Text("\(nutriments.fat_serving ?? 0, specifier: "%.1f") \(nutriments.fat_unit ?? "g") fat")
                    .font(Font.custom("DMSans-Medium", size: 15))
                Divider()
                Text("\(nutriments.carbohydrates_serving ?? 0, specifier: "%.1f") \(nutriments.carbohydrates_unit ?? "g") carbs")
                    .font(Font.custom("DMSans-Medium", size: 15))
                Spacer()
            }
            .frame(height: 20)
        }
    }
}
