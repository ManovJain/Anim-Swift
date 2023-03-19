//
//  AllergensViewButton.swift
//  Anim
//
//  Created by Manovski on 3/14/23.
//

import SwiftUI


struct AllergensViewButton: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    var name: String
    @State var selected = false
    
    
    var body: some View {
        VStack {
            Button {
                updateAllergens(input: name)
            } label: {
                VStack {
                    Text(getname(name: name))
                        .font(Font.custom("DMSans-Medium", size: 50))
                        .padding(5)
                        .foregroundColor(.primary)
                    Text(name)
                        .font(Font.custom("DMSans-Medium", size: 15))
                        .foregroundColor(getTextColor())
                        .lineLimit(1)
                }
                .frame(width: 100, height: 100)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .cornerRadius(15)
                .padding()
                .background(getColor())
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color("AnimGreen"), lineWidth: 5))
            }
            .background(getColor())
            .cornerRadius(16)
        }
    }
    
    func getname(name: String) -> String {
        if name == "milk" {
            return "🥛"
        }
        else if name == "gluten"{
            return "🍞"
        }
        else if name == "peanuts" {
            return "🥜"
        }
        else if name == "soybeans" {
            return "🫘"
        }
        else if name == "eggs" {
            return "🥚"
        }
        else if name == "nuts" {
            return "🌰"
        }
        else if name == "fish" {
            return "🐠"
        }
        else {
            return "🚫"
        }
    }
    
    func getColor() -> Color {
        if (userViewModel.user.allergens?.contains(name) == true) {
            return Color("AnimGreen")
        }
        else {
            return Color.white
        }
    }
    
    func getTextColor() -> Color {
        if (userViewModel.user.allergens?.contains(name) == true) {
            return Color.white
        }
        else {
            return Color("AnimGreen")
        }
    }
    
    func updateAllergens(input: String){
        if((userViewModel.user.allergens?.contains(input)) == true){
            userViewModel.user.allergens?.removeAll(where: { $0 == input })
            print(userViewModel.user.allergens!)
        }
        else {
            userViewModel.user.allergens?.append(input)
            print(userViewModel.user.allergens!)
        }
    }
    
}
