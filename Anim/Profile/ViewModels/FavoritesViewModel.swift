//
//  FavoriteViewModel.swift
//  Anim
//
//  Created by Manovski on 2/8/23.
//

import Foundation

//favList {
//    "123",
//    "123"
//}

final class FavoritesViewModel: ObservableObject {
    @Published var favList: Array = ["123", "123"]
}

