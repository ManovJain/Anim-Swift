//
//  ScannedFoodViewModel.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 12/7/22.
//

import Foundation

enum CurrentTagSelected: String {
    case fat = "fat"
    case salt = "salt"
    case saturatedFat = "saturated fat"
    case sugar = "sugar"
}

final class ScannedFoodViewModel: ObservableObject {
    @Published var currentTagSelected: CurrentTagSelected = .fat
    
    @Published var currentTagLevel: String = "low"
}

