//
//  DismissButton.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 2/6/23.
//

import SwiftUI

struct DismissButton: View {
    
    let defaults = UserDefaults.standard
    
    @Binding var openedApp: Bool
    
    
    var body: some View {
        Button("Use Anim") {
            defaults.set(true, forKey: "openedApp")
            openedApp = true
        }
        .padding()
        .foregroundColor(Color("background"))
        .background(Color("AnimGreen"))
        .clipShape(Capsule())
    }
}
