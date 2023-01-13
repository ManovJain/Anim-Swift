//  FoodButtonRow.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 12/2/22.
//

import SwiftUI

struct FoodButtonRow: View {
    
    @State var isLiked: Bool = false
    @State var isDisliked: Bool = false
    
    @State var nutriments: Nutriments
    
    var body: some View {
        HStack {
            Spacer()
            if let check = nutriments.sodium_serving {
                NavigationLink {
                    NutrientsPage(nutriments: nutriments)
                } label: {
                    //                        Image(systemName: "heart.fill")
                    //                            .foregroundColor(.red)
                    //                            .font(.system(size: 25))
                    Text("Nutrition Information")
                        .padding(6)
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(.blue, lineWidth: 1)
                        )
                        .font(.system(size: 18))
                    
                }
            }
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
