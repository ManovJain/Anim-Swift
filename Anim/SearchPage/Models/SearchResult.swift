//
//  Search.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 11/30/22.
//

import Foundation

struct SearchResult: Codable {
    let text: String?
    let parsed: [FoodList]
    let hints: [FoodList]
}
