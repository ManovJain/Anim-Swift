//  FoodButtonRow.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 12/2/22.
//

import SwiftUI

struct FoodButtonRow: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    @State var isLiked: Bool = false
    @State var isDisliked: Bool = false
    
    @State var nutriments: Nutriments
    @State var product: Product
    
    var body: some View {
        HStack {
            Spacer()
            if nutriments.sodium_serving != nil {
                NavigationLink {
                    NutrientsPage(nutriments: nutriments)
                } label: {
                    //                        Image(systemName: "heart.fill")
                    //                            .foregroundColor(.red)
                    //                            .font(.system(size: 25))
                    Text("Nutrition Information")
                        .font(Font.custom("DMSans-Medium", size: 17))
                        .padding(6)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.blue, lineWidth: 1)
                        )
                }
            }
            Button {
                if !(userViewModel.user.favorites!.contains((product._id)!)) {
                    userViewModel.user.favorites?.append((product._id)!)
                } else {
                    userViewModel.user.favorites = userViewModel.user.favorites?.filter { $0 != (product._id)! }
                }
            } label: {
                if !(userViewModel.user.favorites!.contains((product._id)!)) {
                    Text("Save")
                        .font(Font.custom("DMSans-Medium", size: 20))
                        .foregroundColor(Color("background"))
                } else {
                    Text("Unsave")
                        .font(Font.custom("DMSans-Medium", size: 20))
                        .foregroundColor(Color("background"))
                }
            }
            .padding()
            .background(Color("AnimGreen"))
            .cornerRadius(15)
            .padding(.horizontal)
            .clipShape(Capsule())
            .disabled((userViewModel.state ==  .signedOut))
            //                else {
            //                    Image(systemName: "heart.fill")
            //                        .foregroundColor(.red)
            //                        .font(.system(size: 25))
            //                }
            Spacer()
            //            Button {
            //                if isLiked {
            //                    isLiked = false
            //                }
            //                else {
            //                    isLiked = true
            //                    isDisliked = false
            //                }
            //            } label: {
            //                Image(systemName: isLiked ? "hand.thumbsup.fill" : "hand.thumbsup")
            //                    .foregroundColor(isLiked ? .blue : .primary)
            //                    .font(.system(size: 25))
            //            }
            //            Button {
            //                if isDisliked {
            //                    isDisliked = false
            //                }
            //                else {
            //                    isLiked = false
            //                    isDisliked = true
            //                }
            //            } label: {
            //                Image(systemName: isDisliked ? "hand.thumbsdown.fill" : "hand.thumbsdown")
            //                    .foregroundColor(isDisliked ? .blue : .primary)
            //                    .font(.system(size: 25))
            //            }
            //            Spacer()
            //            Button {
            //
            //            } label: {
            //                Image(systemName: "plus")
            //                    .font(.system(size: 25))
            //            }
        }
    }
}
