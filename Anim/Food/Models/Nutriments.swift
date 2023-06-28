//
//  Nutriments.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 12/2/22.
//

import Foundation

struct Nutriments: Codable {
    let calcium_serving: Float?
    let calcium_unit: String?
    let carbohydrates_serving: Float?
    let carbohydrates_unit: String?
    let carbohydrates_value: Float?
    let cholesterol_serving: Float?
    let cholesterol_unit: String?
    let energy_kcal_serving: Float?
    let energy_kcal: Float?
    let energy_unit: String?
    let fat_serving: Float?
    let fat_value: Float?
    let fat_unit: String?
    let saturated_fat_serving: Float?
    let saturated_fat_unit: String?
    let trans_fat_serving: Float?
    let trans_fat_unit: String?
    let fiber_serving: Float?
    let fiber_unit: String?
    let iron_serving: Float?
    let iron_unit: String?
    let proteins_serving: Float?
    let proteins_value: Float?
    let proteins_unit: String?
    let salt_serving: Float?
    let salt_unit: String?
    let sodium_serving: Float?
    let sodium_unit: String?
    let sugars_serving: Float?
    let sugars_unit: String?
    
    enum CodingKeys : String, CodingKey {
        case calcium_serving = "calcium_serving"
        case calcium_unit = "calcium_unit"
        case carbohydrates_serving = "carbohydrates_serving"
        case carbohydrates_unit = "carbohydrates_unit"
        case carbohydrates_value = "carbohydrates_value"
        case cholesterol_serving = "cholesterol_serving"
        case cholesterol_unit = "cholesterol_unit"
        case energy_kcal_serving = "energy-kcal_serving"
        case energy_kcal = "energy-kcal"
        case energy_unit = "energy_unit"
        case fat_serving = "fat_serving"
        case fat_value = "fat_value"
        case fat_unit = "fat_unit"
        case saturated_fat_serving = "saturated-fat_serving"
        case saturated_fat_unit = "saturated-fat_unit"
        case trans_fat_serving = "trans-fat_serving"
        case trans_fat_unit = "trans-fat_unit"
        case fiber_serving = "fiber_serving"
        case fiber_unit = "fiber_unit"
        case iron_serving = "iron_serving"
        case iron_unit = "iron_unit"
        case proteins_serving = "proteins_serving"
        case proteins_value = "proteins_value"
        case proteins_unit = "proteins_unit"
        case salt_serving = "salt_serving"
        case salt_unit = "salt_unit"
        case sodium_serving = "sodium_serving"
        case sodium_unit = "sodium_unit"
        case sugars_serving = "sugars_serving"
        case sugars_unit = "sugars_unit"
    }
}
