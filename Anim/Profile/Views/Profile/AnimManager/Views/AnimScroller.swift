//
//  AnimScroller.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 2/23/23.
//

import SwiftUI

enum NumNeededType {
    case search
    case scan
    case nutriments
}

struct AnimScroller: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    var iconVM = IconVM()
    
    let rows = [
        GridItem(.fixed(70))
    ]
    
    
    @State var icons: [IconModel]
    
    @State var numNeeded: Int
    
    @State var numNeededType: NumNeededType
    
    let defaults = UserDefaults.standard
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: rows, alignment: .center) {
                ForEach(icons, id: \.self) { icon in
                    Button(action: {
                        userViewModel.user.anim = icon.name
                        self.defaults.set(icon.name, forKey: "anim")
                    }) {
                        VStack {
                            if (numNeeded >= icon.numNeeded) {
                                Image(icon.name)
                                    .resizable()
                                    .frame(width: 70, height: 70)
                            }
                            else {
                                Image(icon.name)
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .blur(radius: numNeeded < icon.numNeeded ? 15 : 0)
                                    .padding(10)
                            }
                            if (numNeeded >= icon.numNeeded) {
                                Text("Anim Earned!")
                                    .lineLimit(nil)
                                    .font(Font.custom("DMSans-Medium", size: 13))
                                    .foregroundColor(Color("AnimGreen"))
                            }
                            else {
                                switch numNeededType {
                                case .search:
                                    Text("Search \(icon.numNeeded - numNeeded) more")
                                        .lineLimit(nil)
                                        .font(Font.custom("DMSans-Medium", size: 13))
                                        .foregroundColor(Color("AnimGreen"))
                                case .scan:
                                    Text("Scan \(icon.numNeeded - numNeeded) more")
                                        .lineLimit(nil)
                                        .font(Font.custom("DMSans-Medium", size: 13))
                                        .foregroundColor(Color("AnimGreen"))
                                case .nutriments:
                                    Text("Submit \(icon.numNeeded - numNeeded) more fixes")
                                        .lineLimit(nil)
                                        .font(Font.custom("DMSans-Medium", size: 11))
                                        .foregroundColor(Color("AnimGreen"))
                                }
                            }
                        }
                        .frame(width: 70, height: 200)
                    }
                    .disabled(numNeeded < icon.numNeeded)
                }
                .padding()
            }
        }
    }
    
}
