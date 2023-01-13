//
//  NavModel.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 11/29/22.
//

import Foundation

enum CurrentPageNav: Int, CaseIterable {
    case camera
    case food
    case explore
    case profile
    
    mutating func next() {
        let allCases = type(of: self).allCases
        self = allCases[(allCases.firstIndex(of: self)! + 1) % allCases.count]
    }
    
    mutating func previous() {
        let allCases = type(of: self).allCases
        if (allCases.firstIndex(of: self) == 0) {
            self = allCases[3]
        }
        else {
            self = allCases[(allCases.firstIndex(of: self)! - 1) % allCases.count]
        }
    }
}

final class NavModel: ObservableObject {
    @Published var currentPage: CurrentPageNav = .camera
}
