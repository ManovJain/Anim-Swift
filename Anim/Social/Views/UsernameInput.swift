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
    case special
    case taken
}

struct UsernameInput: View {
    
    @EnvironmentObject var exploreViewModel: ExploreViewModel
    
    @EnvironmentObject var userViewModel: UserViewModel

    @State private var username = ""
    
    @State var usernameIssue: UsernameIssues = .valid
    
    @State var missingUsername: Bool = false
    
    var body: some View {
        ZStack {
            VStack (alignment: .center) {
                TextField(
                    "Username",
                    text: $username
                )
                .frame(width: 200)
                .textInputAutocapitalization(.never)
                .autocorrectionDisabled()
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
                if (usernameIssue == .special) {
                    Text("Username contains invalid character")
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
                        exploreViewModel.dismissedUsername = true
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
        if username.count >= 3 && username.count <= 15{
            FirestoreRequests().checkUsername(username: username.lowercased()) { data in
                if data {
                    usernameIssue = .taken
                }
                else if checkForSpecialCharacters(string: username) {
                    usernameIssue = .special
                }
                else {
                    usernameIssue = .valid
                }
            }
        }
        else if checkForSpecialCharacters(string: username) {
            usernameIssue = .special
        }
        else {
            usernameIssue = .length
        }
    }
    
    func createUsername() {
        userViewModel.user.username = username.lowercased()
        userViewModel.user.hasSetUsername = true
        FirestoreRequests().addUsernameToArray(username: username.lowercased())
    }
    
    func checkForSpecialCharacters(string: String) -> Bool{
        let characterset = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789_")
        if string.rangeOfCharacter(from: characterset.inverted) == nil {
            return false
        }
        return true
    }
}
