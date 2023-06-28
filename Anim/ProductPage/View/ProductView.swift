//
//  ProductView.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 6/15/23.
//

import SwiftUI

struct ProductView: View {
    
    @EnvironmentObject var camModel: CameraViewModel
    @EnvironmentObject var foodViewModel: FoodViewModel
    @EnvironmentObject var userViewModel: UserViewModel
    
    @State var product: Product?
    
    @State var nutrientLevels = [NutrientLevelKey]()
    
    @State var ingredientsList: String = ""
    
    @State var status: Int?
    
    @State var findingProduct = false
    
    @State var numServings = 1
    
    var body: some View {
        ZStack {
            Color("background").edgesIgnoringSafeArea(.all)
            if findingProduct {
                ProgressView()
            }
            else if status == nil{
                Text("Search or scan a product")
                    .font(Font.custom("DMSans-Medium", size: 24))
                    .foregroundColor(Color("AnimGreen"))
                    .frame(alignment: .center)
            }
            else if status == 0 {
                Text("Oh no! We don't have data on this product yet but our team is currently working to solve that issue.")
                    .padding()
                    .font(Font.custom("DMSans-Medium", size: 24))
                    .foregroundColor(Color("AnimGreen"))
                    .frame(alignment: .center)
            }
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
                                if (nutriments.calcium_serving != nil) {
                                    VStack (alignment: .leading, spacing: 3) {
                                        if numServings > 1 {
                                            Text("Nutrition Information (\(numServings) servings)")
                                                .foregroundColor(.gray)
                                                .padding(.horizontal)
                                                .padding([.top], 4)
                                                .multilineTextAlignment(.leading)
                                                .font(Font.custom("DMSans-Medium", size: 18))
                                        }
                                        else {
                                            Text("Nutrition Information (\(numServings) serving)")
                                                .foregroundColor(.gray)
                                                .padding(.horizontal)
                                                .padding([.top], 4)
                                                .multilineTextAlignment(.leading)
                                                .font(Font.custom("DMSans-Medium", size: 18))
                                        }
                                        NutritionFacts(nutriments: nutriments, numServings: $numServings)
                                            .padding([.horizontal])
                                            .padding([.bottom], 8)
                                    }
                                    Divider()
                                }
                                
                            }
                            if let _ = product.ingredients {
                                VStack (alignment: .leading, spacing: 3) {
                                    Text("Ingredients")
                                        .bold()
                                        .padding(.horizontal)
                                        .padding([.top], 4)
                                        .multilineTextAlignment(.leading)
                                        .font(Font.custom("DMSans-Medium", size: 18))
                                    Text(ingredientsList)
                                        .lineSpacing(7)
                                        .foregroundColor(.gray)
                                        .padding([.horizontal])
                                        .font(Font.custom("DMSans-Medium", size: 18))
                                }
                                Divider()
                            }
                            if let grade = product.nutriscore_grade {
                                VStack (alignment: .leading, spacing: 3) {
                                    Text("Nutriscore Grade")
                                        .bold()
                                        .padding(.horizontal)
                                        .padding([.top], 4)
                                        .multilineTextAlignment(.leading)
                                        .font(Font.custom("DMSans-Medium", size: 18))
                                    Text("This product recieved a nutriscore grade of \(grade.uppercased()). This is a grade calculated by the Food Standards Agency by comparing negative and positive ingredients in a product. Be aware this grade is only meant to give a general idea of the nutrional value of the product and you should do your own research into what a healthy product means to you.\n\n")
                                        .lineSpacing(7)
                                        .foregroundColor(.gray)
                                        .padding([.horizontal])
                                        .font(Font.custom("DMSans-Medium", size: 18))
                                }
                            }
                        }
                    }
                }
            }
        }
        .overlay(product?.nutriments?.proteins_unit != nil ? LogButton(nutriments: (product?.nutriments)!, numServings: $numServings) : nil, alignment: .bottom)
        .overlay(((userViewModel.state ==  .signedIn && product != nil) ? FoodButtons(product: product!): nil)?.allowsHitTesting(true)
            .position(x: UIScreen.screenWidth/1.15, y: 65)
        )
        .onAppear {
            print(UIScreen.screenHeight/17)
            if camModel.scannedBarcode != "No Barcode Scanned Yet" {
                findingProduct = true
                NetworkRequests().getFoodByBarcode(barcode: camModel.scannedBarcode) { data in
                    findingProduct = false
                    status = data?.status
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
                    if let addProduct = data?.product {
                        FirestoreRequests().addProduct(addProduct: addProduct)
                    }
                    if status != 1 {
                        FirestoreRequests().addBarcodeToMissing(array: "missingBarcode", barcode: camModel.scannedBarcode)
                    }
                    if let uid = userViewModel.user.uid {
                        if uid != "" {
                            if !(userViewModel.user.productsViewed!.contains(camModel.scannedBarcode)) {
                                userViewModel.user.productsScanned = userViewModel.user.productsScanned! + 1
                                userViewModel.user.productsViewed?.append(camModel.scannedBarcode)
                            }
                            
                        }
                    }
                    
                }
            }
            else if foodViewModel.product != nil {
                findingProduct = true
                status = foodViewModel.status
                product = foodViewModel.product
                findingProduct = false
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
                if let addProduct = foodViewModel.product {
                    FirestoreRequests().addProduct(addProduct: addProduct)
                }
                findingProduct = false
                if let uid = userViewModel.user.uid {
                    if uid != "" {
                        if !(userViewModel.user.productsViewed!.contains((foodViewModel.product?._id)!)) {
                            userViewModel.user.productsFromSearch = userViewModel.user.productsFromSearch! + 1
                            userViewModel.user.productsViewed?.append((foodViewModel.product?._id)!)
                        }
                    }
                }
            }
        }
    }
}
