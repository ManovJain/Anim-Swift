//
//  ProductImage.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 6/15/23.
//

import SwiftUI

struct ProductImage: View {
    @State var product: Product
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                AsyncImage(
                    url: URL(string: product.image_front_url!)) { image in
                        image.resizable()
                            .frame(width: UIScreen.screenWidth, height: UIScreen.screenWidth - 200)
                            .blur(radius: 50)
                            .opacity(0.5)
                    } placeholder: {
                        ProgressView()
                    }
                AsyncImage(
                    url: URL(string: product.image_front_url!)) { image in
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.screenWidth - 60, height: UIScreen.screenWidth - 200)
                            .blur(radius: 20)
                            .opacity(0.55)
                    } placeholder: {
                        ProgressView()
                    }
                AsyncImage(
                    url: URL(string: product.image_front_url!)) { image in
                        image.resizable()
                            .cornerRadius(10)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: UIScreen.screenWidth - 60, height: UIScreen.screenWidth - 200)
                    } placeholder: {
                        ProgressView()
                    }
            }
            Text(product.product_name_en!.capitalized)
                .padding([.horizontal])
                .bold()
                .font(.system(size: 22))
        }
        
    }
}
