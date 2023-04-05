//
//  ViewOffsetKey.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 4/4/23.
//

import Foundation
import Combine
import SwiftUI

struct ViewOffsetKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue = CGFloat.zero
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}
