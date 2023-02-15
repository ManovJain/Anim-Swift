//
//  AnimManager.swift
//  Anim
//
//  Created by Manovski on 12/19/22.
//

import Foundation
import SwiftUI

struct AnimManager: View {
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    var iconVM = IconVM()
    
    let rows = [
        GridItem(.fixed(70))
    ]
    
    @State var productsFromSearch = 0
    @State var productsScanned = 0
    
    let defaults = UserDefaults.standard
    
    var body: some View {
        Text("Anim Manager")
            .font(Font.custom("DMSans-Medium", size: 30))
            .foregroundColor(Color("AnimGreen"))
            .lineLimit(1)
            .frame(alignment: .center)
        VStack {
            Image(userViewModel.userModel.anim!)
                .resizable()
                .frame(width: 80, height: 80)
                .padding()
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color("AnimGreen"), lineWidth: 3)
                    )
            Text("My Anim")
                .lineLimit(nil)
                .font(Font.custom("DMSans-Medium", size: 20))
                .foregroundColor(Color("AnimGreen"))
            Spacer()
                .frame(height: 50)
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: rows, alignment: .center) {
                        ForEach(iconVM.searchIcons, id: \.self) { icon in
                            Button(action: {
                                userViewModel.userModel.anim = icon.name
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
                                            .font(Font.custom("DMSans-Medium", size: 15))
                                            .foregroundColor(Color("AnimGreen"))
                                    }
                                    else {
                                        Text("Search \(icon.numNeeded - productsFromSearch) more")
                                            .lineLimit(nil)
                                            .font(Font.custom("DMSans-Medium", size: 15))
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
                ScrollView(.horizontal, showsIndicators: false) {
                    LazyHGrid(rows: rows, alignment: .center) {
                        ForEach(iconVM.scanIcons, id: \.self) { icon in
                            Button(action: {
                                userViewModel.userModel.anim = icon.name
                                self.defaults.set(icon.name, forKey: "anim")
                            }) {
                                VStack {
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
                                            .font(Font.custom("DMSans-Medium", size: 15))
                                            .foregroundColor(Color("AnimGreen"))
                                    }
                                    else {
                                        Text("Scan \(icon.numNeeded - productsScanned) more")
                                            .lineLimit(nil)
                                            .font(Font.custom("DMSans-Medium", size: 15))
                                            .foregroundColor(Color("AnimGreen"))
                                    }
                                }
                                .frame(width: 70, height: 200)
                            }
                            .disabled(productsScanned < icon.numNeeded)
                        }
                        .padding()
                    }
                }
            }
            .frame(height: 300)
            .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color("AnimGreen"), lineWidth: 3)
                )
        }
        .onAppear {
            productsFromSearch = userViewModel.userModel.productsFromSearch!
            productsScanned = userViewModel.userModel.productsScanned!
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
