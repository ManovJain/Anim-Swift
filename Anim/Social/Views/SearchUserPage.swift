//
//  SearchUserPage.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 4/6/23.
//

import SwiftUI

struct SearchUserPage: View {
    
    @State var users = [User]()
    
    @State var searchText = ""
    
    var body: some View {
        ZStack {
            Color("background").edgesIgnoringSafeArea(.all)
            List {
                ForEach(users, id: \.self) { user in
                    Text(user.username!)
                }
            }
            .searchable(text: $searchText)
        }
        .onChange(of: searchText) { value in
            FirestoreRequests().getUserSearch(searchTerm: searchText) { data in
                print(data)
                users = data!
            }
        }
    }
}
