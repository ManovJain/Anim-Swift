//
//  FilterViewModel.swift
//  Anim
//
//  Created by Manovski on 2/23/23.
//

import Foundation

enum ScoreFilter: String {
    case none = ""
    case a = "&nutrition_grades_tags=a"
    case b = "&nutrition_grades_tags=b"
    case c = "&nutrition_grades_tags=c"
    case d = "&nutrition_grades_tags=d"
    case e = "&nutrition_grades_tags=e"
}

enum GeoFilter: String {
    case world = "world"
    case us = "us"
    case es = "es"
}

final class FilterViewModel: ObservableObject {
    @Published var scoreFilter: ScoreFilter = .none
    @Published var geoFilter: GeoFilter = .world
}
