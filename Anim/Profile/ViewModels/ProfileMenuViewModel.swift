//
//  ProfilePageViewModel.swift
//  Anim
//
//  Created by Manovski on 1/13/23.
//

import Foundation

enum Icon: String {
    case user = "user"
    case animManager = "Anim Manager"
    case favorites = "favorites"
    case settings = "settings"
}

final class ProfileMenuViewModel: ObservableObject {
    @Published var icon: Icon = .settings
}

