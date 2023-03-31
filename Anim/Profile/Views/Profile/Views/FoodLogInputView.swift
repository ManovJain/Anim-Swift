//
//  FoodLogInputView.swift
//  Anim
//
//  Created by Manovski on 3/28/23.
//

import SwiftUI

struct FoodLogInputView: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    @State private var calories: Float = 0
    @State private var carbs: Float = 0
    @State private var fat: Float = 0
    @State private var protein: Float = 0
    
    var body: some View {
        VStack(spacing: 5) {
            Text("Daily Calorie Goal")
                .font(Font.custom("DMSans-Medium", size: 15))
                .foregroundColor(Color("AnimGreen"))
            TextField("Daily Calorie Goal", value: ($userViewModel.nutrition.totalCalories), format: .number)
                .textFieldStyle(FoogLogInputStyle())
            Text("Daily Carbs Goal")
                .font(Font.custom("DMSans-Medium", size: 15))
                .foregroundColor(Color("AnimGreen"))
            TextField("Daily Carbs Goal", value: ($userViewModel.nutrition.totalCarbs), format: .number)
                .textFieldStyle(FoogLogInputStyle())
            Text("Daily Fat Goal")
                .font(Font.custom("DMSans-Medium", size: 15))
                .foregroundColor(Color("AnimGreen"))
            TextField("Daily Fat Goal", value: ($userViewModel.nutrition.totalFat), format: .number)
                .textFieldStyle(FoogLogInputStyle())
            Text("Daily Protein Goal")
                .font(Font.custom("DMSans-Medium", size: 15))
                .foregroundColor(Color("AnimGreen"))
            TextField("Daily Protein Goal", value: ($userViewModel.nutrition.totalProtein), format: .number)
                .textFieldStyle(FoogLogInputStyle())
        }
    }
    
}



struct FoogLogInputStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .font(Font.custom("DMSans-Medium", size: 15))
            .foregroundColor(Color("AnimGreen"))
            .lineLimit(1)
            .keyboardType(.numberPad)
            .padding(10)
            .textFieldStyle(.roundedBorder)
            .multilineTextAlignment(.center)
            .frame(width: 250)
    }
}


struct FoodLogInputView_Previews: PreviewProvider {
    static var previews: some View {
        FoodLogInputView()
    }
}
