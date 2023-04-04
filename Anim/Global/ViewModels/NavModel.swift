//
//  NavModel.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 11/29/22.
//

import Foundation
import SwiftUI

enum CurrentPageNav: Int, CaseIterable {
    case camera
    case food
    case explore
    case social
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
    
    
    @Published var cameraEdge: Edge = Edge.leading
    @Published var productEdge: Edge = Edge.trailing
    @Published var profileEdge: Edge = Edge.trailing
    @Published var socialEdge: Edge = Edge.trailing
    @Published var exploreEdge: Edge = Edge.trailing
}
