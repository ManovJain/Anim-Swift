//
//  FoodItem.swift
//  Anim
//
//  Created by Manovski on 12/8/22.
//

import Foundation
struct FoodItem: Codable, Hashable {
    
    static func == (lhs: FoodItem, rhs: FoodItem) -> Bool {
        lhs._id
        ==
        rhs._id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(_id)
    }
    
    
    let _id: String?
    let product_name_en: String?
    let image_front_url: String?
    let nutriscore_grade: String?
    let code: String?
}

