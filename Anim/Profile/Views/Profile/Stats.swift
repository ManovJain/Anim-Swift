//
//  Stats.swift
//  Anim
//
//  Created by Manovski on 12/16/22.
//

import Foundation
import SwiftUI

struct Stats: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            VStack {
                VStack (alignment: .center){
                    Text("New Foods")
                        .underline()
                    Text("17")
                }
                Spacer()
                    .frame(height: 10)
                VStack (alignment: .center){
                    Text("Products Scanned")
                        .underline()
                    Text("38")
                }
                Spacer()
                    .frame(height: 10)
                VStack (alignment: .center){
                    Text("Foods Searched")
                        .underline()
                    Text("22")
                }
                Spacer()
                    .frame(height: 10)
                VStack (alignment: .center){
                    Text("Animals Saved")
                        .underline()
                    Text("3")
                }
            }
        }
        .frame(height: 50)
    }
}

struct Stats_Previews: PreviewProvider {
    static var previews: some View {
        Stats()
    }
}
