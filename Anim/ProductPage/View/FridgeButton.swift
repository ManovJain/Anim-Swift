//
//  FridgeButton.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 6/27/23.
//

import SwiftUI

struct FridgeButton: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    @State var product: Product
    
    var body: some View {
        if((userViewModel.user.fridgeItems!.contains(product._id!) == true)){
            Button {
                userViewModel.user.fridgeItems?.removeAll(where: { $0 == product._id })
            } label: {
                Image(systemName: "refrigerator.fill")
                    .font(.system(size: 30))
                    .foregroundColor(Color("AnimGreen"))
                Text("-")
                    .font(Font.custom("DMSans-Medium", size: 15))
                    .foregroundColor(Color("AnimGreen"))
                    .lineLimit(1)
            }
        }
        else {
            Button {
                userViewModel.user.fridgeItems!.append(product._id!)
            } label: {
                Image(systemName: "refrigerator")
                    .font(.system(size: 30))
                    .foregroundColor(Color("AnimGreen"))
                Text("+")
                    .font(Font.custom("DMSans-Medium", size: 15))
                    .foregroundColor(Color("AnimGreen"))
                    .lineLimit(1)
            }
        }
    }
}
