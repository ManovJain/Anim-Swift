//
//  Allergens.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 12/7/22.
//

import SwiftUI

struct Allergens: View {
    
    var tags: [String]
    
    var body: some View {
        VStack (alignment: .leading, spacing: 0){
            Text("Allergens")
                .underline()
                .font(Font.custom("DMSans-Medium", size: 20))
            HStack (alignment: .top) {
                ForEach(tags, id: \.self) { tag in
                    Text((tag.dropFirst(3)).capitalized)
                    Divider()
                }
                Spacer()
            }
            .frame(height: 20)
        }
    }
}

