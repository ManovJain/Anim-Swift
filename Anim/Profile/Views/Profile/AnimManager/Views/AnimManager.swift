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
            Image(userViewModel.user.anim ?? "animLogoIcon")
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
                AnimScroller(icons: iconVM.searchIcons, animEarnedType: .search)
                AnimScroller(icons: iconVM.scanIcons, animEarnedType: .scanned)
                AnimScroller(icons: iconVM.nutrimentsIcons, animEarnedType: .nutrimentsFixed)
            }
            .frame(height: 400)
            .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color("AnimGreen"), lineWidth: 3)
                )
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
