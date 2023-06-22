//
//  LogButton.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 6/21/23.
//

import SwiftUI

struct LogButton: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    @State var nutriments: Nutriments
    @Binding var numServings: Int
    
    var body: some View {
        HStack {
            Spacer()
            Stepper("", value: $numServings, in: 1...10)
                .fixedSize()
            Button("LOG", action: { addFood()})
                .buttonStyle(MenuButtonStyle())
            Spacer()
            
        }
    }
    func addFood(){
        userViewModel.nutrition.calories! += Int((nutriments.energy_kcal_serving ?? 0) * Float(numServings))
        
        userViewModel.nutrition.carbs! += Int((nutriments.carbohydrates_serving ?? 0) * Float(numServings))
        
        userViewModel.nutrition.fat! += Int((nutriments.fat_serving ?? 0) * Float(numServings))
        
        userViewModel.nutrition.protein! += Int((nutriments.proteins_serving ?? 0) * Float(numServings))
        
        numServings = 1
    }
}
