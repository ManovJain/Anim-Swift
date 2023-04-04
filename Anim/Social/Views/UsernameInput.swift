//
//  UsernameInput.swift
//  Anim
//
//  Created by Pattison, Brian (Cognizant) on 4/4/23.
//

import SwiftUI

enum UsernameIssues {
    case valid
    case length
    case taken
}

struct UsernameInput: View {
    
    @EnvironmentObject var exploreViewModel: ExploreViewModel
    
    @EnvironmentObject var userViewModel: UserViewModel

    @State private var username = ""
    
    @State var usernameIssue: UsernameIssues = .valid
    
    var body: some View {
        ZStack {
            Color("background").edgesIgnoringSafeArea(.all)
            VStack (alignment: .center) {
                TextField(
                    "Username",
                    text: $username
                )
                .frame(width: 200)
                .textInputAutocapitalization(.never)
                .padding()
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(Color("AnimGreen"), lineWidth: 1)
                )
                if (usernameIssue == .length && !username.isEmpty) {
                    Text("Username must be between 3 and 15 characters")
                        .foregroundColor(.red)
                        .font(Font.custom("DMSans-Medium", size: 12))
                }
                if (usernameIssue == .taken) {
                    Text("Username already in use")
                        .foregroundColor(.red)
                        .font(Font.custom("DMSans-Medium", size: 12))
                }
                Spacer()
                    .frame(height: 40)
                HStack {
                    Button {
                        exploreViewModel.dismissedUsername = true
                        createUsername()
                        NotificationCenter.default.post(name: NSNotification.usernameCreated, object: nil)
                    } label: {
                        Text("Create Username")
                            .font(Font.custom("DMSans-Medium", size: 13))
                            .foregroundColor(Color("background"))
                            .lineLimit(1)
                    }
                    .disabled(usernameIssue != .valid)
                    .padding()
                    .background(Color("AnimGreen"))
                    .cornerRadius(15)
                    .clipShape(Capsule())
                    Button {
                    } label: {
                        Text("Create Later")
                            .font(Font.custom("DMSans-Medium", size: 13))
                            .foregroundColor(Color("background"))
                            .lineLimit(1)
                    }
                    .padding()
                    .background(.red)
                    .cornerRadius(15)
                    .clipShape(Capsule())
                }
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color("AnimGreen"), lineWidth: 1)
            )
            .background(
                RoundedRectangle(
                    cornerRadius: 16
                )
                .foregroundColor(Color("background"))
            )
            .onChange(of: username) { newValue in
                checkUsername()
            }
        }
        Spacer()
            .frame(height: 250)
    }
    
    func checkUsername() {
        if username.count >= 3 && username.count <= 15 {
            FirestoreRequests().checkUsername(username: username) { data in
                if data {
                    usernameIssue = .taken
                }
                else {
                    usernameIssue = .valid
                }
            }
        }
        else {
            usernameIssue = .length
        }
    }
    
    func createUsername() {
        userViewModel.user.username = username
        userViewModel.user.hasSetUsername = true
        FirestoreRequests().addUsernameToArray(username: username)
    }
}

struct UsernameInput_Previews: PreviewProvider {
    static var previews: some View {
        UsernameInput()
    }
}
