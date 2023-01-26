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
    let username: String?
    let email: String?
    let productsFromSearch: Int?
    let productsScanned: Int?
    let productsViewed: [String]?
    let likes: [String]?
    let dislikes: [String]?
    let favorites: [String]?
    let allergens: [String]?
}
