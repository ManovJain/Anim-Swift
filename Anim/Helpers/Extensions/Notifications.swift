//
//  File.swift
//  Anim
//
//  Created by Manovski on 2/3/23.
//

import Foundation
import SwiftUI


extension NSNotification {
    static let signInStateChange = Notification.Name.init("signInStateChange")
    static let showAnimAlert = Notification.Name.init("showAnimAlert")
    static let refreshPosts = Notification.Name.init("refreshPosts")
    static let usernameCreated = Notification.Name.init("usernameCreated")
}
