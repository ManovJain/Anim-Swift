//
//  Ingredients.swift
//  Anim
//
//  Created by Manovski on 4/7/23.
//

import SwiftUI

struct Ingredients: View {
    var ingredients: [Ingredient]
    
    var body: some View {
        VStack (alignment: .leading, spacing: 0){
            Text("Ingredients")
                .underline()
                .font(Font.custom("DMSans-Medium", size: 20))
            ScrollView(.horizontal){
                HStack (alignment: .top) {
                    ForEach(ingredients, id: \.self) { ingredient in
                        Text(ingredient.text!)
                        Divider()
                    }
                    Spacer()
                }
                .frame(height: 20)
            }
        }
    }
}
