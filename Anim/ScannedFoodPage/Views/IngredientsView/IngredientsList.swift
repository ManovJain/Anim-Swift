//
//  IngredientsList.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 12/6/22.
//

import SwiftUI

struct IngredientsList: View {
    
    var ingredients: [Ingredient]
    
    var body: some View {
        List {
            ForEach(ingredients, id: \.id) { ingredient in
                HStack {
                    Text((ingredient.text!).capitalized)
                    Spacer()
                    VStack {
                        Text("\(ingredient.percent_estimate!, specifier: "%.1f") %")
                            .frame(width: 65)
                            .foregroundColor(Color(UIColor.lightGray))
                            .padding(2)
                    }
                    .background(Color(UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)))
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color(UIColor.lightGray), lineWidth: 1)
                    )
                }
            }
        }
        .navigationTitle("Ingredients")
    }
}
