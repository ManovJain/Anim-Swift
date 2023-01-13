//
//  QuickStats.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 11/29/22.
//

import SwiftUI

struct User: View {
    var body: some View {
        VStack(){
            Image(systemName: "person")
                .foregroundColor(.indigo)
                .frame(width: 200, height: 200)
                .clipShape(Circle())
                .overlay(Circle()
                .stroke(Color.indigo, lineWidth: 2))
        }
        .padding()
        .frame(
              minWidth: 0,
              maxWidth: .infinity,
              minHeight: 0,
              maxHeight: .infinity
            )
    }
}

struct User_Previews: PreviewProvider {
    static var previews: some View {
        User()
    }
}
