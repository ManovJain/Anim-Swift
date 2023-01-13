//
//  ProductImage.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 12/7/22.
//

import SwiftUI

struct ProductImage: View {
    
    var imageURL: String
    var grade: String
    
    var body: some View {
        AsyncImage(
            url: URL(string: imageURL)) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.screenWidth - 120, height: UIScreen.screenWidth - 120)
                    .clipShape(Rectangle())
                    .padding(10)
                    .background(Color.white)
                    .border(.green, width: 2)
            } placeholder: {
                ProgressView()
            }
            .overlay(GradeOverlay(grade: grade), alignment: .bottomTrailing)
            .padding(.bottom)
    }
}
