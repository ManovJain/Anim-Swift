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
    @State var progressValue: Float = 0.0
    
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
                    ProgressView(value: 10, total: 100)
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
                    ProgressView(value: 10, total: 100)
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
                    ProgressView(value: 10, total: 100)
                        .frame(width: 100)
                        .tint(lime)
                    Text("\(userViewModel.nutrition.protein!)")
                        .font(Font.custom("DMSans-Medium", size: 25))
                        .foregroundColor(Color("AnimGreen"))
                    
                }
            }
//            VStack {
//                HStack{
//                    Text("Carbs")
//                        .font(Font.custom("DMSans-Medium", size: 25))
//                        .foregroundColor(Color("AnimGreen"))
//                        .lineLimit(1)
//                        .frame(width: 100)
//                    ProgressView(value: userViewModel.nutrition.carbs as! BinaryFloatingPoint, total: userViewModel.nutrition.totalCarbs as! BinaryFloatingPoint)
//                        .frame(width: 100)
//                        .tint(ice)
//                }
//                HStack{
//                    Text("Fat")
//                        .font(Font.custom("DMSans-Medium", size: 25))
//                        .foregroundColor(Color("AnimGreen"))
//                        .lineLimit(1)
//                        .frame(width: 100)
//                    ProgressView(value: userViewModel.nutrition.fat, total: userViewModel.nutrition.totalFat)
//                        .frame(width: 100)
//                        .tint(strawberry)
//                }
//                HStack{
//                    Text("Protein")
//                        .font(Font.custom("DMSans-Medium", size: 25))
//                        .foregroundColor(Color("AnimGreen"))
//                        .lineLimit(1)
//                        .frame(width: 100)
//                    ProgressView(value: userViewModel.nutrition.protein, total: userViewModel.nutrition.totalProtein)
//                        .frame(width: 100)
//                        .tint(lime)
//                }
            }
        }
    }
    
//    func ring(for color: Color) -> some View {
//
//        var calPercentage = (userViewModel.nutrition.calories!)/(userViewModel.nutrition.totalCalories!)
//
//        // Background ring
//        Circle()
//            .stroke(style: StrokeStyle(lineWidth: 16))
//            .foregroundStyle(.tertiary)
//            .overlay {
//                // Foreground ring
//                Circle()
//                    .trim(from: 0, to: drawingStroke ? CGFloat(calPercentage) : 0)
////                    .trim(from: 0, to: drawingStroke ? 0.5 : 0)
//                    .stroke(color.gradient,
//                            style: StrokeStyle(lineWidth: 16, lineCap: .round))
//            }
//            .rotationEffect(.degrees(-90))
//    }
    
//}

struct FoodLogView_Previews: PreviewProvider {
    static var previews: some View {
        FoodLogView()
    }
}
