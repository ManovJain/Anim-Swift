//
//  AllergenButton.swift
//  Anim
//
//  Created by Manovski on 3/4/23.
//
import SwiftUI


struct AllergenButton: View {
    
    var name: String
    var selected: Bool
    
    
    var body: some View {
        Text(getname(name: name))
            .font(Font.custom("DMSans-Medium", size: 15))
            .padding(5)
            .background(getColor(selected: selected))
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
        else {
            return "🚫"
        }
    }
    
//    func filterColor(name: String, filterVal: String) -> Color{
//        if filterVal == name {
//            return Color("AnimGreen")
//        }
//        else {
//            return Color.white
//        }
//    }
    
    func getColor(selected: Bool) -> Color {
        if selected == true {
            return Color("AnimGreen")
        }
        else {
            return Color.white
        }
    }
}
