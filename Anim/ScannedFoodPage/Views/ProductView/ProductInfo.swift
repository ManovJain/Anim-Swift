//
//  ProductInfo.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 12/7/22.
//

import SwiftUI

struct ProductInfo: View {
    
    var foundProduct: Product
    
    @Binding var alertShown: Bool
    
    var body: some View {
        VStack {
            if let ingredients = foundProduct.ingredients {
                NavigationLink {
                    IngredientsList(ingredients: ingredients)
                }
            label: {
                Text(((foundProduct.generic_name_en) ?? (foundProduct.product_name_en ?? "Food")).capitalized)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                    .frame(alignment: .center)
            }
            }
            else {
                Text(((foundProduct.generic_name_en) ?? (foundProduct.product_name_en ?? "Food")).capitalized)
                    .font(.title2)
                    .fontWeight(.bold)
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                    .frame(alignment: .center)
            }
            if let imageURL = foundProduct.image_front_url {
                ProductImage(imageURL: imageURL, grade: foundProduct.nutriscore_grade ?? "NA")
            }
            else {
                ProductImage(imageURL: "https://i.imgur.com/9eJFAzo.png", grade: foundProduct.nutriscore_grade ?? "NA")
            }
            VStack (alignment: .leading, spacing: 8) {
                FoodButtonRow(nutriments: foundProduct.nutriments!)
                VStack (spacing: 2){
                    Macros(nutriments: foundProduct.nutriments!)
                    if foundProduct.allergens_tags!.count > 0 {
                        Allergens(tags: foundProduct.allergens_tags!)
                    }
                    if let levels = foundProduct.nutrient_levels {
                        NutrientTagsList(nutrientLevels: levels, alertShown: $alertShown)
                            .frame(width: UIScreen.screenWidth - 50)
                    }
                }
            }
            Spacer()
                .frame(height: UIScreen.screenHeight / 10)
        }
        .frame(width: UIScreen.screenWidth - 50)
    }
}
