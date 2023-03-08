//
//  TransitionExtensions.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 3/8/23.
//

import SwiftUI
import Foundation

extension AnyTransition {
    
    
    static var backwards : AnyTransition {
        AnyTransition.asymmetric(
            insertion: .move(edge: .trailing),
            removal: .move(edge: .leading))
    }
}

