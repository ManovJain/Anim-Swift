//
//  FoodLogView.swift
//  Anim
//
//  Created by Manovski on 3/27/23.
//

import SwiftUI

class UserObj {
    var calories = 10
}

struct FoodLogView: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    @State private var user = UserObj()
    @State private var showingAlert = false
    
    let strawberry = Color(#colorLiteral(red: 1, green: 0.1857388616, blue: 0.5733950138, alpha: 1))
    let lime = Color(#colorLiteral(red: 0.5563425422, green: 0.9793455005, blue: 0, alpha: 1))
    let ice = Color(#colorLiteral(red: 0.4513868093, green: 0.9930960536, blue: 1, alpha: 1))
    
    var body: some View {
        VStack {
            VStack {
                Text("Calories:")
                    .font(Font.custom("DMSans-Medium", size: 25))
                    .foregroundColor(Color("AnimGreen"))
                    .lineLimit(1)
                Text("\(userViewModel.nutrition.calories!) / \(userViewModel.nutrition.totalCalories!)")
                    .font(Font.custom("DMSans-Medium", size: 25))
                    .foregroundColor(Color("AnimGreen"))
                    .lineLimit(1)
                Spacer()
                    .frame(height: 20)
                RingView()
            }
            Spacer()
                .frame(height: 25)
            VStack {
                HStack{
                    Text("Carbs")
                        .font(Font.custom("DMSans-Medium", size: 25))
                        .foregroundColor(Color("AnimGreen"))
                        .lineLimit(1)
                        .frame(width: 100)
                    ProgressView(value: Double(userViewModel.nutrition.carbs!), total: 100)
                        .frame(width: 100)
                        .tint(ice)
                    Text("\(userViewModel.nutrition.carbs!)")
                        .font(Font.custom("DMSans-Medium", size: 25))
                        .foregroundColor(Color("AnimGreen"))
                }
                HStack{
                    Text("Fat")
                        .font(Font.custom("DMSans-Medium", size: 25))
                        .foregroundColor(Color("AnimGreen"))
                        .lineLimit(1)
                        .frame(width: 100)
                    ProgressView(value: Double(userViewModel.nutrition.fat!), total: 100)
                        .frame(width: 100)
                        .tint(strawberry)
                    Text("\(userViewModel.nutrition.fat!)")
                        .font(Font.custom("DMSans-Medium", size: 25))
                        .foregroundColor(Color("AnimGreen"))
                }
                HStack{
                    Text("Protein")
                        .font(Font.custom("DMSans-Medium", size: 25))
                        .foregroundColor(Color("AnimGreen"))
                        .lineLimit(1)
                        .frame(width: 100)
                    ProgressView(value: Double(userViewModel.nutrition.protein!), total: 100)
                        .frame(width: 100)
                        .tint(lime)
                    Text("\(userViewModel.nutrition.protein!)")
                        .font(Font.custom("DMSans-Medium", size: 25))
                        .foregroundColor(Color("AnimGreen"))
                }
            }
            Spacer()
            Button{
                showingAlert = true
            } label: {
                Image(systemName: "info.circle")
                    .font(.system(size: 30))
            }
            .alert(isPresented:$showingAlert) {
                Alert(
                    title: Text("Nutrition"),
                    message: Text("Nutrition is in beta, calories & macros will reset at CST midnight everyday."),
                    dismissButton: .default((Text("Got it!")))
                )
            }
        }
    }
    
}

struct FoodLogView_Previews: PreviewProvider {
    static var previews: some View {
        FoodLogView()
    }
}
