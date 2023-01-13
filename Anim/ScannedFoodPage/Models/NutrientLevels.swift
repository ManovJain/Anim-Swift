//
//  NutrientLevsl.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 12/2/22.
//

import Foundation

struct NutrientLevels: Codable {
    let fat: String?
    let salt: String?
    let saturatedFat: String?
    let sugars: String?
    
    enum CodingKeys : String, CodingKey {
        case fat = "fat"
        case salt = "salt"
        case sugars = "sugars"
        case saturatedFat = "saturated-fat"
    }
}
