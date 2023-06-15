//
//  File.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 6/15/23.
//

import Foundation

struct NutrientLevelKey: Hashable {
    static func == (lhs: NutrientLevelKey, rhs: NutrientLevelKey) -> Bool {
        lhs.id == rhs.id
    }
    
    public func hash(into hasher: inout Hasher) {
        return hasher.combine(id)
    }
    
    let id = UUID()
    let value: (String, String)
}
