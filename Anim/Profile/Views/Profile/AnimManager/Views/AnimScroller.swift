//
//  AnimScroller.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 2/23/23.
//

import SwiftUI

enum AnimEarnedType {
    case search
    case scanned
    case nutrimentsFixed
}

struct AnimScroller: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    var iconVM = IconVM()
    
    let rows = [
        GridItem(.fixed(70))
    ]
    
    @State var productsFromSearch = 0
    @State var productsScanned = 0
    @State var nutrimentsFixed = 0
    
    @State var icons: [IconModel]
    
    @State var animEarnedType: AnimEarnedType
    
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
                            switch animEarnedType {
                            case .search:
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
                            case .scanned:
                                if (productsScanned >= icon.numNeeded) {
                                    Image(icon.name)
                                        .resizable()
                                        .frame(width: 70, height: 70)
                                }
                                else {
                                    Image(icon.name)
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .blur(radius: productsScanned < icon.numNeeded ? 15 : 0)
                                        .padding(10)
                                }
                                if (productsScanned >= icon.numNeeded) {
                                    Text("Anim Earned!")
                                        .lineLimit(nil)
                                        .font(Font.custom("DMSans-Medium", size: 13))
                                        .foregroundColor(Color("AnimGreen"))
                                }
                                else {
                                    Text("Scan \(icon.numNeeded - productsScanned) more")
                                        .lineLimit(nil)
                                        .font(Font.custom("DMSans-Medium", size: 13))
                                        .foregroundColor(Color("AnimGreen"))
                                }
                            case .nutrimentsFixed:
                                if (nutrimentsFixed >= icon.numNeeded) {
                                    Image(icon.name)
                                        .resizable()
                                        .frame(width: 70, height: 70)
                                }
                                else {
                                    Image(icon.name)
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .blur(radius: nutrimentsFixed < icon.numNeeded ? 15 : 0)
                                        .padding(10)
                                }
                                if (nutrimentsFixed >= icon.numNeeded) {
                                    Text("Anim Earned!")
                                        .lineLimit(nil)
                                        .font(Font.custom("DMSans-Medium", size: 13))
                                        .foregroundColor(Color("AnimGreen"))
                                }
                                else {
                                    Text("Fix \(icon.numNeeded - nutrimentsFixed) more products")
                                        .lineLimit(nil)
                                        .font(Font.custom("DMSans-Medium", size: 10))
                                        .foregroundColor(Color("AnimGreen"))
                                }
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
            nutrimentsFixed = userViewModel.user.numNutrimentsReported!
            
            print(nutrimentsFixed)
        }
    }
    
}
