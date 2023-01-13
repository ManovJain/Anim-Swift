//
//  ProfilePageViewModel.swift
//  Anim
//
//  Created by Manovski on 1/13/23.
//

import Foundation

enum Icon: String {
    case fat = "fat"
    case salt = "salt"
    case saturatedFat = "saturated fat"
    case sugar = "sugar"
}

final class ProfilePageViewModel: ObservableObject {
    @Published var icon: Icon = .fat

}


//Make this a State Var in ContentView
//Use this as an environment variable in profilePage
