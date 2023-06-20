//
//  ProductView.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 6/15/23.
//

import SwiftUI

struct ProductView: View {
    
    @State var product: Product?
    
    @State var nutrientLevels = [NutrientLevelKey]()
    
    @State var ingredientsList: String = ""
    
    var body: some View {
        VStack {
            if let product = product {
                if product.image_front_url != nil {
                    ProductImage(product: product)
                }
                ScrollView {
                    VStack (alignment: .leading){
                            FlexibleView(
                                availableWidth: UIScreen.screenWidth, data: nutrientLevels,
                                spacing: 10,
                                alignment: .leading
                            ) { item in
                                QuickTag(nutrient: item.value.0, level: item.value.1)
                            }
                            .padding(.horizontal)
                        Divider()
                        if let nutriments = product.nutriments {
                            Text("Nutrition Information")
                                .foregroundColor(.gray)
                                .padding(.horizontal)
                                .padding([.top], 4)
                                .multilineTextAlignment(.leading)
                                .font(.system(size: 18))
                            NutritionFacts(nutriments: nutriments)
                                .padding([.horizontal])
                                .padding([.top], 4)
                                .padding([.bottom], 8)
                            Divider()
                        }
                        if let ingredients = product.ingredients {
                            Text("Ingredients")
                                .bold()
                                .padding(.horizontal)
                                .padding([.top], 4)
                                .multilineTextAlignment(.leading)
                                .font(.system(size: 18))
                            Text(ingredientsList)
                                .lineSpacing(10)
                                .foregroundColor(.gray)
                                .padding([.horizontal])
                                .padding([.top], 4)
                                .padding([.bottom], 8)
                        }
                    }
                }
            }
        }
        .onAppear {
            NetworkRequests().getFoodByBarcode(barcode: "0048500008607") { data in
                product = data?.product
                if let nutrients = product?.nutrient_levels {
                    if let fat = nutrients.fat {
                        nutrientLevels.append(NutrientLevelKey(value: ("Fat" , fat)))
                    }
                    if let salt = nutrients.salt {
                        nutrientLevels.append(NutrientLevelKey(value: ("Salt" , salt)))
                    }
                    if let sugar = nutrients.sugars {
                        nutrientLevels.append(NutrientLevelKey(value: ("Sugar" , sugar)))
                    }
                    if let sfat = nutrients.saturatedFat {
                        nutrientLevels.append(NutrientLevelKey(value: ("Saturated Fat" , sfat)))
                    }
                }
                if let ingredients = product!.ingredients {
                    let ingredientCount = ingredients.count
                    if ingredientCount > 0 {
                        for (index, ingredient) in ingredients.enumerated() {
                            let isLastIngredient = index == ingredientCount - 1
                            let ingredientText = ingredient.text!.lowercased()
                            
                            if index == 0 {
                                // Capitalize the first letter of the first ingredient
                                let firstIngredientText = ingredientText.prefix(1).capitalized + ingredientText.dropFirst()
                                ingredientsList += firstIngredientText
                            } else if isLastIngredient {
                                // Handle the last ingredient without the comma
                                ingredientsList += " and " + ingredientText
                            } else {
                                ingredientsList += ", " + ingredientText
                            }
                        }
                        
                        ingredientsList += "."
                    }
                }

            }
        }
    }
}
