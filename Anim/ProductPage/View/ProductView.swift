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
                        Text("Nutrition Information")
                            .foregroundColor(.gray)
                            .padding(.horizontal)
                            .multilineTextAlignment(.leading)
                            .font(.system(size: 14))
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
            }
        }
    }
}
