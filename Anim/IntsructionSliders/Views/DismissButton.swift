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
        .foregroundColor(Color("AnimGreen" ))
        .background(Color(red: 51/255, green: 114/255, blue: 58/255))
        .clipShape(Capsule())
    }
}
