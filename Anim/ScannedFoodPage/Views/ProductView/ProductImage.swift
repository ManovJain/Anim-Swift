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
    
    @Binding var gradeAlertShown: Bool
    
    var body: some View {
        AsyncImage(
            url: URL(string: imageURL)) { image in
                image.resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: UIScreen.screenWidth - 120, height: UIScreen.screenWidth - 120)
                    .clipShape(Rectangle())
                    .padding(10)
                    .background(Color("background"))
                    .border(.green, width: 2)
            } placeholder: {
                ProgressView()
            }
            .overlay(GradeOverlay(grade: grade, gradeAlertShown: $gradeAlertShown), alignment: .bottomTrailing)
            .padding(.bottom)
    }
}
