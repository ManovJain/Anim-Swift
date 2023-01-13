//
//  Placeholder.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 11/29/22.
//

import SwiftUI

struct Placeholder: View {
    
    var page: String
    
    var body: some View {
        VStack (alignment: .center) {
            Spacer()
            Text(page)
                .frame(alignment: .center)
            Spacer()
        }
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity
        )
    }
}
