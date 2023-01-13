//
//  Favorites.swift
//  Anim
//
//  Created by Manovski on 12/16/22.
//

import Foundation
import SwiftUI

struct Favorites: View {
    //    @static private var favorites = ["apple", "pear", "watermelon"]
    var body: some View {
        VStack(alignment: .leading) {
            ScrollView{
                ForEach((1...10).reversed(), id: \.self) {_ in
                    Button() {
                        print("Button tapped!")
                    } label: {
                        HStack{
                            Image(systemName: "bird")
                                .foregroundColor(.indigo)
                            Text("Food Name")
                                .foregroundColor(.indigo)
                            Spacer()
                            
                            Text("A")
                                .font(.caption)
                                .padding(10)
                                .background(.green)
                                .clipShape(Circle())
                                .foregroundColor(.primary)
                            Spacer()
                        }
                        .padding()
                        .overlay(
                            RoundedRectangle(cornerRadius: 4)
                                .stroke(.indigo, lineWidth: 4)
                        )
                    }
                }
            }
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

struct Favorites_Previews: PreviewProvider {
    static var previews: some View {
        Favorites()
    }
}
