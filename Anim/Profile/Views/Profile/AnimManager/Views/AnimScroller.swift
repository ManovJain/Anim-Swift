//
//  AnimScroller.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 2/23/23.
//

import SwiftUI

struct AnimScroller: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    var iconVM = IconVM()
    
    let rows = [
        GridItem(.fixed(70))
    ]
    
    @State var productsFromSearch = 0
    @State var productsScanned = 0
    
    let defaults = UserDefaults.standard
    
    @State var icons: [IconModel]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHGrid(rows: rows, alignment: .center) {
                ForEach(icons, id: \.self) { icon in
                    Button(action: {
                        userViewModel.user.anim = icon.name
                        self.defaults.set(icon.name, forKey: "anim")
                    }) {
                        VStack {
                            if (productsFromSearch >= icon.numNeeded) {
                                Image(icon.name)
                                    .resizable()
                                    .frame(width: 70, height: 70)
                            }
                            else {
                                Image(icon.name)
                                    .resizable()
                                    .frame(width: 50, height: 50)
                                    .blur(radius: productsFromSearch < icon.numNeeded ? 15 : 0)
                                    .padding(10)
                            }
                            if (productsFromSearch >= icon.numNeeded) {
                                Text("Anim Earned!")
                                    .lineLimit(nil)
                                    .font(Font.custom("DMSans-Medium", size: 13))
                                    .foregroundColor(Color("AnimGreen"))
                            }
                            else {
                                Text("Search \(icon.numNeeded - productsFromSearch) more")
                                    .lineLimit(nil)
                                    .font(Font.custom("DMSans-Medium", size: 13))
                                    .foregroundColor(Color("AnimGreen"))
                            }
                        }
                        .frame(width: 70, height: 200)
                    }
                    .disabled(productsFromSearch < icon.numNeeded)
                }
                .padding()
            }
        }
        .onAppear {
            productsFromSearch = userViewModel.user.productsFromSearch!
            productsScanned = userViewModel.user.productsScanned!
        }
    }
    
}
