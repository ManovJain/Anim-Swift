import SwiftUI

struct MacrosView: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    @State var nutriments: Nutriments
    @State private var sleepAmount = 8.0
    @State var multiplier: Float = 1
    
    var body: some View {
        VStack(spacing: 10){
            Spacer()
            VStack{
                Text("\(multiplier.formatted()) serving(s)")
                Spacer()
                HStack (spacing: 25){
                    VStack {
                        Text("\((nutriments.energy_kcal_serving ?? 0) * multiplier, specifier: "%.1f")")
                            .font(Font.custom("DMSans-Medium", size: 20))
                        Text("calories")
                            .font(Font.custom("DMSans-Medium", size: 15))
                    }
                    VStack {
                        Text("\((nutriments.proteins_serving ?? 0) * multiplier, specifier: "%.1f") \(nutriments.proteins_unit ?? "g")")
                            .font(Font.custom("DMSans-Medium", size: 20))
                        Text("protein")
                            .font(Font.custom("DMSans-Medium", size: 15))
                    }
                    VStack {
                        Text("\((nutriments.fat_serving ?? 0) * multiplier, specifier: "%.1f") \(nutriments.fat_unit ?? "g")")
                            .font(Font.custom("DMSans-Medium", size: 20))
                        Text("fat")
                            .font(Font.custom("DMSans-Medium", size: 15))
                    }
                    VStack {
                        Text("\((nutriments.carbohydrates_serving ?? 0) * multiplier, specifier: "%.1f") \(nutriments.carbohydrates_unit ?? "g")")
                            .font(Font.custom("DMSans-Medium", size: 20))
                        Text("carbs")
                            .font(Font.custom("DMSans-Medium", size: 15))
                    }
                }
                HStack {
                    Spacer()
                    Stepper("", value: $multiplier, in: 0...10)
                        .fixedSize()
                    Button("LOG", action: { addFood()})
                        .buttonStyle(MenuButtonStyle())
                    Spacer()
                }
            }
        }
    }
    
    func addFood(){
        userViewModel.nutrition.calories! += Int((nutriments.energy_kcal_serving ?? 0) * multiplier)
        print(userViewModel.nutrition.calories!)
        
        userViewModel.nutrition.carbs! += Int((nutriments.carbohydrates_serving ?? 0) * multiplier)
        print(userViewModel.nutrition.carbs!)
        
        userViewModel.nutrition.fat! += Int((nutriments.fat_serving ?? 0) * multiplier)
        print(userViewModel.nutrition.fat!)
        
        userViewModel.nutrition.protein! += Int((nutriments.proteins_serving ?? 0) * multiplier)
        print(userViewModel.nutrition.protein!)
    }
}
