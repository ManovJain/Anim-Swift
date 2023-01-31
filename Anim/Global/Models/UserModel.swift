//
//  User.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 12/2/22.
//

import Foundation

struct UserModel: Codable, Hashable {
    
    static func == (lhs: UserModel, rhs: UserModel) -> Bool {
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
}
