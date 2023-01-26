//
//  UserViewModel.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 1/24/23.
//

import Foundation
import Firebase

final class UserViewModel: ObservableObject {
    @Published var user: UserModel?
}
