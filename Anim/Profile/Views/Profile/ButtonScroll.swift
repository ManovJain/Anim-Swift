//
//  ButtonScroll.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 11/29/22.
//

import SwiftUI
import CachedAsyncImage

struct ButtonScroll: View {
    
    let items = 1...6

    let rows = [
        GridItem(.fixed(50))
    ]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: rows, alignment: .center) {
                ForEach(items, id: \.self) { item in
                    CachedAsyncImage(
                        url: URL(string: "https://images.squarespace-cdn.com/content/v1/56031d09e4b0dc68f6197723/1469030770980-URDU63CK3Q4RODZYH0S1/Grey+Box.jpg?format=1500w"),
                        content: { image in
                            image.resizable()
                                .frame(width: 150, height: 150)
                                .cornerRadius(20)
                        },
                        placeholder: {
                            ProgressView()
                        }
                    ).onTapGesture {
                        print("image clicked")
                    }
                    .accessibilityIdentifier("story")
                }
            }
        }
    }
}

struct ButtonScroll_Previews: PreviewProvider {
    static var previews: some View {
        ButtonScroll()
    }
}
