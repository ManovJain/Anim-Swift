//
//  FoodButtons.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 6/27/23.
//

import SwiftUI

struct FoodButtons: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    @State var product: Product
    
    var body: some View {
        VStack (alignment: .leading, spacing: 10) {
            if !(userViewModel.user.favorites!.contains((product._id)!)) {
                FavoriteFoodButton(favorited: true, id: (product._id)!)
            } else {
                FavoriteFoodButton(favorited: false, id: (product._id)!)
            }
            FridgeButton(product: product)
        }
    }
}
