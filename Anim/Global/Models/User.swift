//
//  User.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 12/2/22.
//

import Foundation

struct User: Codable, Hashable {
    
    static func == (lhs: User, rhs: User) -> Bool {
        lhs.uid == rhs.uid
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uid)
    }
    
    let uid: String?
    var username: String?
    let email: String?
    var productsFromSearch: Int?
    var productsScanned: Int?
    var productsViewed: [String]?
    var likes: [String]?
    var dislikes: [String]?
    var favorites: [String]?
    var allergens: [String]?
    var recentSearches: [String]?
    var anim: String?
    var earnedAnims: [String]?
    var fridgeItems: [String]?
    var geoPreference: String?
    var gradePreference: String?
    var numNutrimentsReported: Int?
    var followers: [String]?
    var folowing: [String]?
    var likedPosts: [String]?
    var isPublic: Bool?
    var hasSetUsername: Bool?
}
