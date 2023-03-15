//
//  AllergensViewButton.swift
//  Anim
//
//  Created by Manovski on 3/14/23.
//

import SwiftUI


struct AllergensViewButton: View {
    
    var name: String
    var selected: Bool
    
    
    var body: some View {
        VStack {
            Text(getname(name: name))
                .font(Font.custom("DMSans-Medium", size: 60))
                .padding(5)
                .foregroundColor(.primary)
            Text(name)
                .font(Font.custom("DMSans-Medium", size: 12))
        }
        .frame(width: 100, height: 100)
        .padding()
        .background(getColor(selected: selected))
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(Color("AnimGreen"), lineWidth: 3))
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
    
    func getColor(selected: Bool) -> Color {
        if selected == true {
            return Color("AnimGreen")
        }
        else {
            return Color.white
        }
    }
}

//struct AllergensViewButton_Previews: PreviewProvider {
//    static var previews: some View {
//        AllergensViewButton(name: String, selected: Bool)
//    }
//}
