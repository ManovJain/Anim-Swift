//
//  Product.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 12/2/22.
//

import Foundation

struct Product: Codable {
    let _id: String?
    let _keywords: [String]?
    let allergens: String?
    let allergens_tags: [String]?
    let brand_owner: String?
    let brand_owner_imported: String?
    let brands: String?
    let brands_tags: [String]?
    let categories_hierarchy: [String]?
    let countries: String?
    let food_groups_tags: [String]?
    let generic_name_en: String?
    let product_name_es: String?
    let product_name: String?
    let image_front_url: String?
    let image_ingredients_url: String?
    let image_nutrition_url: String?
    let ingredients: [Ingredient]?
    let ingredients_ids_debug: [String]?
    let ingredients_that_may_be_from_palm_oil_n: Int?
    let labels_old: String?
    let labels_tags: [String]?
    let manufacturing_places_tags: [String]?
    let nutrient_levels: NutrientLevels?
    let nutriments: Nutriments?
    let nutriscore_grade: String?
    let nutriscore_score: Int?
    let origins: String?
    let packaging_tags: [String]?
    let product_name_en: String?
    let serving_size: String?
    let traces_hierarchy: [String]?
    let vitamins_tags: [String]?
}
