//
//  DateExtensions.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 4/5/23.
//

import Foundation

extension Date {
    func timeAgoDisplay() -> String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        let string = formatter.localizedString(for: self, relativeTo: Date())
        if string == "in 0 seconds" {
            return "Just now"
        }
        else {
            return string
        }
    }
}
