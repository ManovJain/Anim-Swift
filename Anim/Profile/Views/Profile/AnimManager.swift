//
//  AnimManager.swift
//  Anim
//
//  Created by Manovski on 12/19/22.
//

import Foundation
import SwiftUI

struct AnimManager: View {
    @State private var anim = "bird"
    var body: some View {
        HStack {
            Button(action: {
                    anim = "bird"
                }) {
                    VStack {
                        Image(systemName: "bird")
                            .font(.system(size: 60))
                            .foregroundColor(.red)
                        Text("bird")
                    }
                }
                Button(action: {
                    anim = "bird"
                }) {
                    VStack {
                        Image(systemName: "bird")
                            .font(.system(size: 60))
                            .foregroundColor(.indigo)
                        Text("bird")
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
    

struct AnimManager_Previews: PreviewProvider {
    static var previews: some View {
        AnimManager()
    }
}
