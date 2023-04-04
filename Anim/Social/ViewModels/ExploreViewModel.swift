//
//  ExploreViewModel.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 4/3/23.
//

import Foundation

enum FeedType {
    case explore
    case following
}

final class ExploreViewModel: ObservableObject {
    @Published var feedType: FeedType = .explore
    
    @Published var dismissedUsername: Bool = false
}
