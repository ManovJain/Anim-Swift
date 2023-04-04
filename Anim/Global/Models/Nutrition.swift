//
//  Nutrition.swift
//  Anim
//
//  Created by Manovski on 3/28/23.
//

import Foundation

struct Nutrition: Codable, Hashable {
    
    let uid: String?
    var nutritionSet: Bool?
    var calories: Int?
    var carbs: Int?
    var fat: Int?
    var protein: Int?
    var totalCalories: Int?
    var totalCarbs: Int?
    var totalFat: Int?
    var totalProtein: Int?
}
