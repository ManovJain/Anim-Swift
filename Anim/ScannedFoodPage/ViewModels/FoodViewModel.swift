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

final class FoodViewModel: ObservableObject {
    @Published var currentTagSelected: CurrentTagSelected = .fat
    
    @Published var currentTagLevel: String = "low"
    
    @Published var product: Product?
    
    @Published var searchTerm: String = ""
    
    @Published var searchResults: [FoodItem] = [FoodItem]()
    
    @Published var status: Int?
}

