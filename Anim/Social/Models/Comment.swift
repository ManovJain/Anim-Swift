//
//  Comment.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 4/3/23.
//

import Foundation

struct Comment: Codable, Hashable {
    
    static func == (lhs: Comment, rhs: Comment) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let id: String?
    var postID: String?
    let userID: String?
    var content: String?
    var datePosted: Date?
}
