//
//  UserNavTitle.swift
//  Anim
//
//  Created by Manovski on 4/6/23.
//

import SwiftUI

struct UserNavTitle: View {
    
    @State var displayName: String
    @State var inputImage: String
    
    var body: some View {
            Text(displayName)
                .font(Font.custom("DMSans-Medium", size: 15))
                .foregroundColor(Color("AnimGreen"))
                .lineLimit(1)
            Image(systemName: inputImage)
                .foregroundColor(Color("AnimGreen"))
    }
}

