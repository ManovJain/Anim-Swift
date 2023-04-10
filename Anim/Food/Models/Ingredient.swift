//
//  Ingredient.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 12/2/22.
//

import Foundation

struct Ingredient: Codable, Hashable {
    
    static func == (lhs: Ingredient, rhs: Ingredient) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let has_sub_ingredients: String?
    let id: String?
    let percent_estimate: Float?
    let percent_max: Float?
    let percent_min: Float?
    let rank: Int?
    let text: String?
    let vegan: String?
    let vegetarian: String?
}
