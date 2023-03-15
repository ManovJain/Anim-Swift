//
//  AllergenButton.swift
//  Anim
//
//  Created by Manovski on 3/4/23.
//
import SwiftUI


struct AllergenButton: View {
    
    @EnvironmentObject var networkRequests: NetworkRequests
    
    var name: String
    var selected: Bool
    
    
    var body: some View {
        Text(getname(name: name))
            .font(Font.custom("DMSans-Medium", size: 15))
            .padding(5)
            .background(getColor())
            .clipShape(Circle())
            .foregroundColor(.primary)
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
        if (networkRequests.allergens.contains(name) == true) {
            return Color("AnimGreen")
        }
        else {
            return Color.white
        }
    }
    
    
}
