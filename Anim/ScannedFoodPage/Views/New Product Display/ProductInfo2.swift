//
//  ProductInfo2.swift
//  Anim
//
//  Created by Manovski on 4/7/23.
//

import SwiftUI

struct ProductInfo2: View {
    
    var foundProduct: Product
    
    @Binding var tagAlertShown: Bool
    @Binding var gradeAlertShown: Bool
    
    var body: some View {
        VStack {
            VStack {
                    Text(((foundProduct.product_name) ?? (foundProduct.generic_name_en ?? "Food")).capitalized)
                        .font(Font.custom("DMSans-Medium", size: 20))
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                        .multilineTextAlignment(.center)
                        .frame(alignment: .center)
                if let imageURL = foundProduct.image_front_url {
                    ProductImage2(imageURL: imageURL, grade: foundProduct.nutriscore_grade ?? "NA", gradeAlertShown: $gradeAlertShown)
                }
                else {
                    ProductImage2(imageURL: "https://i.imgur.com/9eJFAzo.png", grade: foundProduct.nutriscore_grade ?? "NA", gradeAlertShown: $gradeAlertShown)
                }
                FoodButtonRow2(nutriments: foundProduct.nutriments!, product: foundProduct)
                if let ingredients = foundProduct.ingredients {
                    NavigationLink {
                        IngredientsList(ingredients: ingredients)
                    }
                label: {
                    Ingredients(ingredients: ingredients)
                        .foregroundColor(.primary)
                }
                }
            }
            VStack ( spacing: 8) {
                //                    FoodButtonRow(nutriments: foundProduct.nutriments!, product: foundProduct)
                Spacer()
                VStack (spacing: 2){
                    Macros(nutriments: foundProduct.nutriments!)
                    Spacer()
                    if foundProduct.allergens_tags!.count > 0 {
                        Allergens(tags: foundProduct.allergens_tags!)
                    }
                    if let levels = foundProduct.nutrient_levels {
                        NutrientTagsList(nutrientLevels: levels, productID: foundProduct._id! ,tagAlertShown: $tagAlertShown)
                            .frame(width: UIScreen.screenWidth - 50)
                    }
                }
            }
            Spacer()
                .frame(height: UIScreen.screenHeight / 10)
        }
        .onAppear {
            if foundProduct.ingredients == nil {
                FirestoreRequests().addBarcodeToMissing(array: "missingData", barcode: foundProduct._id!)
            }
            if foundProduct.image_front_url == nil {
                FirestoreRequests().addBarcodeToMissing(array: "missingPhoto", barcode: foundProduct._id!)
            }
            
            if let nutriments = foundProduct.nutriments {
                FirestoreRequests().addNutriments(addNutriment: nutriments, productID: foundProduct._id!)
            }
        }
        .frame(width: UIScreen.screenWidth - 50)
    }
}
