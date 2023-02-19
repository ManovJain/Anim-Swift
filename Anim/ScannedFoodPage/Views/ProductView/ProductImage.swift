//
//  ProductImage.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 12/7/22.
//

import SwiftUI
import CachedAsyncImage

struct ProductImage: View {
    
    var imageURL: String
    var grade: String
    
    @Binding var gradeAlertShown: Bool
    
    var body: some View {
        VStack(){
            CachedAsyncImage(
                url: URL(string: imageURL)) { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: UIScreen.screenWidth - 120, height: UIScreen.screenWidth - 120)
                        .padding(10)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(Color("AnimGreen"), lineWidth: 3))
                        .background(Color("background"))
                } placeholder: {
                    ProgressView()
                }
                .overlay(GradeOverlay(grade: grade, gradeAlertShown: $gradeAlertShown), alignment: .bottomTrailing)
                .padding(.bottom)
        }
//        .frame(width: UIScreen.screenWidth - 120, height: UIScreen.screenWidth - 120)
//        .clipShape(RoundedRectangle(cornerRadius: 25.0, style: .circular))
//        .background(Color("background"))
//        .border(Color("AnimGreen"), width: 2)
    }
}
