//
//  SearchResult.swift
//  Anim
//
//  Created by Manovski on 12/8/22.
//

import Foundation

struct SearchResult: Codable {
    let text: Float?
    let products: [FoodItem]
}
