//
//  QuickTag.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 6/15/23.
//

import SwiftUI

struct QuickTag: View {
    
    var nutrient: String
    var level: String
    
    var body: some View {
        Text(getEmoji(level:level) + "  " + level.capitalized + " In " + nutrient.capitalized)
            .bold()
            .font(.system(size: 16))
            .padding(8)
            .background(.gray.opacity(0.2))
            .cornerRadius(8)
    }
}

func getEmoji(level: String) -> String {
    if level == "moderate" {
        return "👌"
    }
    else if level == "low" {
        return "🔥"
    }
    else {
        return "🫤"
    }
}
