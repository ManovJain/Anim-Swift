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
        .foregroundColor(Color(red: 247/255, green: 242/255, blue: 237/255))
        .background(Color(red: 51/255, green: 114/255, blue: 58/255))
        .clipShape(Capsule())
    }
}
