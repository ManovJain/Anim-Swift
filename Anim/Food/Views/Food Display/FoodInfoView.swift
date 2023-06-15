import SwiftUI

struct FoodInfoView: View {
    
    var foundProduct: Product
    
    @Binding var tagAlertShown: Bool
    @Binding var gradeAlertShown: Bool
    
    var body: some View {
        ScrollView {
            VStack {
                Spacer()
                Text(((foundProduct.product_name) ?? (foundProduct.generic_name_en ?? "Food")).capitalized)
                    .font(Font.custom("DMSans-Medium", size: 20))
                    .foregroundColor(.primary)
                    .multilineTextAlignment(.center)
                if let imageURL = foundProduct.image_front_url {
                    ProductImage_Old(imageURL: imageURL, grade: foundProduct.nutriscore_grade ?? "NA", gradeAlertShown: $gradeAlertShown)
                }
                else {
                    ProductImage_Old(imageURL: "https://i.imgur.com/9eJFAzo.png", grade: foundProduct.nutriscore_grade ?? "NA", gradeAlertShown: $gradeAlertShown)
                }
                FoodButtonView(nutriments: foundProduct.nutriments!, product: foundProduct)
            }
            .padding(5)
            Spacer()
                .frame(height: 10)
            VStack () {
                if let levels = foundProduct.nutrient_levels {
                    NutrientTagsList(nutrientLevels: levels, productID: foundProduct._id! ,tagAlertShown: $tagAlertShown)
                    Spacer()
                }
                if let ingredients = foundProduct.ingredients {
                    NavigationLink {
                        IngredientsList(ingredients: ingredients)
                    }
                label: {
                    Ingredients(ingredients: ingredients)
                        .foregroundColor(.primary)
                }
                }
                Spacer()
                if foundProduct.allergens_tags!.count > 0 {
                    Allergens(tags: foundProduct.allergens_tags!)
                }
            }
            Spacer()
            if foundProduct.nutriments?.proteins_serving != nil {
                MacrosView(nutriments: foundProduct.nutriments!)
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
