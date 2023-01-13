//
//  FoodList.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 11/30/22.
//

import Foundation

struct FoodList: Codable, Hashable {
    
    static func == (lhs: FoodList, rhs: FoodList) -> Bool {
        lhs.food.foodId == rhs.food.foodId
    }
    
    var hashValue: Int {
        return (food.foodId).hashValue
    }
    
    let food: Food
}

