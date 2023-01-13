//
//  Food.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 11/30/22.
//

import Foundation

struct Food: Codable {
    let foodId: String?
    let label: String?
    let knownAs: String?
    let nutrients: Nutrients?
    let category: String?
    let categoryLabel: String?
    let image: String?
}
