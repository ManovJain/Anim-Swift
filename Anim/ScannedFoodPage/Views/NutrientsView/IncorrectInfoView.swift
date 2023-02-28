//
//  IncorrectInfoView.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 2/28/23.
//

import SwiftUI

struct IncorrectInfoView: View {
    
    var nutriments: Nutriments
    
    var foodID: String
    
    @Binding var dismissSheet: Bool
    
    @State var calories: Int = 0
    @State var fat: Float = 0
    @State var sat_fat: Float = 0
    @State var trans_fat: Float = 0
    @State var cholesterol: Float = 0
    @State var sodium: Float = 0
    @State var carbs: Float = 0
    @State var fiber: Float = 0
    @State var sugar: Float = 0
    @State var protein: Float = 0
    
    var body: some View {
        ZStack {
            Color("background").edgesIgnoringSafeArea(.all)
            VStack {
                Text("Update Info")
                    .font(Font.custom("DMSans-Medium", size: 30))
                    .padding()
                List {
                    Group{
                        if let _ = nutriments.energy_kcal_serving {
                            HStack {
                                Text("Calories")
                                    .bold()
                                Spacer()
                                TextField(String(calories), value: $calories, format: .number)
                                    .textFieldStyle(.roundedBorder)
                                    .multilineTextAlignment(.center)
                                    .keyboardType(.numberPad)
                                    .fixedSize()
                            }
                        }
                        
                        if let fatUnit = nutriments.fat_unit {
                            HStack {
                                Text("Total Fat")
                                    .bold()
                                    .underline()
                                Spacer()
                                TextField(String(fat), value: $fat, format: .number)
                                    .textFieldStyle(.roundedBorder)
                                    .keyboardType(.numberPad)
                                    .multilineTextAlignment(.center)
                                    .fixedSize()
                                Text(fatUnit)
                            }
                        }
                        
                        if let sFatUnit = nutriments.saturated_fat_unit {
                            HStack {
                                Spacer()
                                    .frame(width: 30)
                                Text("Saturated Fat")
                                Spacer()
                                TextField(String(sat_fat), value: $sat_fat, format: .number)
                                    .textFieldStyle(.roundedBorder)
                                    .keyboardType(.numberPad)
                                    .multilineTextAlignment(.center)
                                    .fixedSize()
                                Text(sFatUnit)
                            }
                        }
                        
                        if let tFatUnit = nutriments.trans_fat_unit {
                            HStack {
                                Spacer()
                                    .frame(width: 30)
                                Text("Trans Fat")
                                Spacer()
                                TextField(String(trans_fat), value: $trans_fat, format: .number)
                                    .textFieldStyle(.roundedBorder)
                                    .keyboardType(.numberPad)
                                    .multilineTextAlignment(.center)
                                    .fixedSize()
                                Text(tFatUnit)
                            }
                        }
                    }
                    if let cholesterolUnit = nutriments.cholesterol_unit {
                        HStack {
                            Text("Cholesterol")
                                .bold()
                            Spacer()
                            TextField(String(cholesterol), value: $cholesterol, format: .number)
                                .textFieldStyle(.roundedBorder)
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.center)
                                .fixedSize()
                            Text(cholesterolUnit)
                        }
                    }
                    
                    if let sodiumUnit = nutriments.sodium_unit {
                        HStack {
                            Text("Sodium")
                                .bold()
                            Spacer()
                            if sodium < 1 {
                                TextField(String(sodium), value: $sodium, format: .number)
                                    .textFieldStyle(.roundedBorder)
                                    .keyboardType(.numberPad)
                                    .multilineTextAlignment(.center)
                                    .fixedSize()
                                Text("mg")
                            }
                            else {
                                TextField(String(sodium), value: $sodium, format: .number)
                                    .textFieldStyle(.roundedBorder)
                                    .keyboardType(.numberPad)
                                    .multilineTextAlignment(.center)
                                    .fixedSize()
                                Text(sodiumUnit)
                            }
                        }
                    }
                    if let carbUnit = nutriments.carbohydrates_unit {
                        HStack {
                            Text("Carbohydrates")
                                .bold()
                            Spacer()
                            TextField(String(carbs), value: $carbs, format: .number)
                                .textFieldStyle(.roundedBorder)
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.center)
                                .fixedSize()
                            Text(carbUnit)
                        }
                    }
                    
                    if let fiberUnit = nutriments.fiber_unit {
                        HStack {
                            Text("Fiber")
                                .bold()
                            Spacer()
                            TextField(String(fiber), value: $fiber, format: .number)
                                .textFieldStyle(.roundedBorder)
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.center)
                                .fixedSize()
                            Text(fiberUnit)
                        }
                    }
                    if let sugarsUnit = nutriments.sugars_unit {
                        HStack {
                            Text("Total Sugars")
                                .bold()
                            Spacer()
                            TextField(String(sugar), value: $sugar, format: .number)
                                .textFieldStyle(.roundedBorder)
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.center)
                                .fixedSize()
                            Text(sugarsUnit)
                        }
                    }
                    if let proteinUnit = nutriments.proteins_unit {
                        HStack {
                            Text("Protein")
                                .bold()
                            Spacer()
                            TextField(String(protein), value: $protein, format: .number)
                                .textFieldStyle(.roundedBorder)
                                .keyboardType(.numberPad)
                                .multilineTextAlignment(.center)
                                .fixedSize()
                            Text(proteinUnit)
                        }
                    }
                    Button {
                        FirestoreRequests().addMissingNutritionInfo(id: foodID, calories: calories, carbs: carbs, cholesterol: cholesterol, fat: fat, fiber: fiber, protein: protein, sat_fat: sat_fat, sodium: sodium, sugar: sugar, trans_fat: trans_fat)
                        dismissSheet.toggle()
                    } label: {
                        HStack {
                            Spacer()
                            Text("Submit")
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
            }
        }
        .onAppear {
            calories = Int(ceil(nutriments.energy_kcal_serving ?? 0.0))
            fat = nutriments.fat_serving ?? 0
            sat_fat = nutriments.saturated_fat_serving ?? 0
            trans_fat = nutriments.trans_fat_serving ?? 0
            cholesterol = nutriments.cholesterol_serving ?? 0
            sodium = nutriments.sodium_serving ?? 0
            if sodium < 1 {
                sodium = sodium * 1000
            }
            carbs = nutriments.carbohydrates_serving ?? 0
            fiber = nutriments.fiber_serving ?? 0
            sugar = nutriments.sugars_serving ?? 0
            protein = nutriments.proteins_serving ?? 0
        }
    }
}
