//  NutrientsPage.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 12/7/22.
//

import SwiftUI

struct NutrientsPage: View {
    
    @State var shouldPresentIncorrectInfo = false
    
    @State private var showToast = false
    
    var nutriments: Nutriments
    
    var foodID: String
    
    var body: some View {
        ZStack{
            Color("background").edgesIgnoringSafeArea(.all)
            VStack {
                List {
                    Group {
                        if let calories = nutriments.energy_kcal_serving {
                            HStack {
                                Text("Calories")
                                    .bold()
                                Spacer()
                                Text("\(Int(ceil(calories)))")
                            }
                        }
                        if let fat = nutriments.fat_unit {
                            HStack {
                                Text("Total Fat")
                                    .bold()
                                    .underline()
                                Spacer()
                                Text("\(nutriments.fat_serving!, specifier: "%.0f")\(fat)")
                            }
                        }
                        if let sat_fat = nutriments.saturated_fat_unit {
                            HStack {
                                Spacer()
                                    .frame(width: 30)
                                Text("Saturated Fat")
                                Spacer()
                                Text("\(nutriments.saturated_fat_serving!, specifier: "%.0f")\(sat_fat)")
                            }
                        }
                        if let trans_fat = nutriments.trans_fat_unit {
                            HStack {
                                Spacer()
                                    .frame(width: 30)
                                Text("Trans Fat")
                                Spacer()
                                Text("\(nutriments.trans_fat_serving!, specifier: "%.0f")\(trans_fat)")
                            }
                        }
                    }
                    if let cholestorol = nutriments.cholesterol_unit {
                        HStack {
                            Text("Cholesterol")
                                .bold()
                            Spacer()
                            Text("\(nutriments.cholesterol_serving!, specifier: "%.0f")\(cholestorol)")
                        }
                    }
                    if let sodium = nutriments.sodium_serving {
                        HStack {
                            Text("Sodium")
                                .bold()
                            Spacer()
                            if nutriments.sodium_serving! < 1 {
                                let sodium = sodium * 1000
                                Text("\(sodium, specifier: "%.0f")mg")
                            }
                            else {
                                Text("\(nutriments.sodium_serving!, specifier: "%.0f")\(sodium)")
                            }
                        }
                    }
                    if let carbs = nutriments.carbohydrates_unit {
                        HStack {
                            Text("Carbohydrates")
                                .bold()
                            Spacer()
                            Text("\(nutriments.carbohydrates_serving!, specifier: "%.0f")\(carbs)")
                        }
                    }
                    if let fiber = nutriments.fiber_unit {
                        HStack {
                            Text("Fiber")
                                .bold()
                            Spacer()
                            Text("\(nutriments.fiber_serving!, specifier: "%.0f")\(fiber)")
                        }
                    }
                    if let sugar = nutriments.sugars_unit {
                        HStack {
                            Text("Total Sugars")
                                .bold()
                            Spacer()
                            Text("\(nutriments.sugars_serving!, specifier: "%.0f")\(sugar)")
                        }
                    }
                    if let protein = nutriments.proteins_unit {
                        HStack {
                            Text("Protein")
                                .bold()
                            Spacer()
                            Text("\(nutriments.proteins_serving!, specifier: "%.0f")\(protein)")
                        }
                    }
                    Button {
                        shouldPresentIncorrectInfo.toggle()
                    } label: {
                        HStack {
                            Spacer()
                            Text("Report Incorrect Info")
                                .font(Font.custom("DMSans-Medium", size: 17))
                                .foregroundColor(.blue)
                                .padding(6)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 10)
                                        .stroke(.blue, lineWidth: 1)
                                )
                            Spacer()
                        }
                    }
                    .buttonStyle(.plain)
                }
                .sheet(isPresented: $shouldPresentIncorrectInfo) {
                    showToast.toggle()
                } content: {
                    IncorrectInfoView(nutriments: nutriments, foodID: foodID, dismissSheet: $shouldPresentIncorrectInfo)
                }
            }
            .toast(message: "Thank you for helping improve our data!",
                         isShowing: $showToast,
                   duration: Toast.long)
        }
        .background(Color("background"))
        .scrollContentBackground(.hidden)
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity
        )
    }
}
