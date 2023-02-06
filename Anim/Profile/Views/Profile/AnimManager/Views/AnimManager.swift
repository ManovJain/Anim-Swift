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
    
    @State var firestoreRequests: FirestoreRequests = FirestoreRequests()
    
    var iconVM = IconVM()
    
    let rows = [
        GridItem(.fixed(70))
    ]

    var body: some View {
        VStack {
            Image(userViewModel.userModel.anim!)
                .resizable()
                .frame(width: 80, height: 80)
                .padding()
                .border(.primary)
            Text("My Anim")
                .lineLimit(nil)
                .foregroundColor(.primary)
            Spacer()
                .frame(height: 50)
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: rows, alignment: .center) {
                    ForEach(iconVM.searchIcons, id: \.self) { icon in
                        Button(action: {
                            userViewModel.userModel.anim = icon.name
                            firestoreRequests.setIcon(uid: userViewModel.userModel.uid!, icon: icon.name)
                        }) {
                            VStack {
                                if (userViewModel.userModel.productsFromSearch! >= icon.numNeeded) {
                                    Image(icon.name)
                                        .resizable()
                                        .frame(width: 70, height: 70)
                                }
                                else {
                                    Image(icon.name)
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .blur(radius: userViewModel.userModel.productsFromSearch! < icon.numNeeded ? 15 : 0)
                                        .padding(10)
                                }
                                if (userViewModel.userModel.productsFromSearch! >= icon.numNeeded) {
                                    Text("Anim Earned!")
                                        .lineLimit(nil)
                                        .font(.system(size: 15))
                                        .foregroundColor(.primary)
                                }
                                else {
                                    Text("Search \(icon.numNeeded - userViewModel.userModel.productsFromSearch!) more")
                                        .lineLimit(nil)
                                        .font(.system(size: 15))
                                        .foregroundColor(.primary)
                                }
                            }
                            .frame(width: 70, height: 300)
                        }
                        .disabled(userViewModel.userModel.productsFromSearch! < icon.numNeeded)
                    }
                    .padding()
                }
            }
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHGrid(rows: rows, alignment: .center) {
                    ForEach(iconVM.scanIcons, id: \.self) { icon in
                        Button(action: {
                            userViewModel.userModel.anim = icon.name
                            firestoreRequests.setIcon(uid: userViewModel.userModel.uid!, icon: icon.name)
                        }) {
                            VStack {
                                if (userViewModel.userModel.productsScanned! >= icon.numNeeded) {
                                    Image(icon.name)
                                        .resizable()
                                        .frame(width: 70, height: 70)
                                }
                                else {
                                    Image(icon.name)
                                        .resizable()
                                        .frame(width: 50, height: 50)
                                        .blur(radius: userViewModel.userModel.productsScanned! < icon.numNeeded ? 15 : 0)
                                        .padding(10)
                                }
                                if (userViewModel.userModel.productsScanned! >= icon.numNeeded) {
                                    Text("Anim Earned!")
                                        .lineLimit(nil)
                                        .font(.system(size: 15))
                                        .foregroundColor(.primary)
                                }
                                else {
                                    Text("Scan \(icon.numNeeded - userViewModel.userModel.productsScanned!) more")
                                        .lineLimit(nil)
                                        .font(.system(size: 15))
                                        .foregroundColor(.primary)
                                }
                            }
                            .frame(width: 70, height: 300)
                        }
                        .disabled(userViewModel.userModel.productsScanned! < icon.numNeeded)
                    }
                    .padding()
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
