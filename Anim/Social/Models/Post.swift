//
//  Post.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 4/3/23.
//

import Foundation

struct Post: Codable, Hashable {
    
    static func == (lhs: Post, rhs: Post) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id: String?
    var userID: String?
    let contentType: String?
    var content: String?
    var caption: String?
    var datePosted: Date?
    var numLikes: Int?
    var likedBy: [String]?
}
