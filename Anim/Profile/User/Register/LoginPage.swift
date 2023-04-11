////
////  Login.swift
//  Anim
//
//  Created by Manovski on 12/6/22.
//
import SwiftUI
import _AuthenticationServices_SwiftUI
import GoogleSignIn
import Firebase
//import GoogleSignInSwift

enum SettingsAlert {
    case deleteAccount
    case publicAccount
    case privateAccount
}
struct LoginPage: View {
    
    let defaults = UserDefaults.standard
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    @EnvironmentObject var profileMenuViewModel: ProfileMenuViewModel
    
    @State var showAlert = false
    
    @Binding var darkMode: Bool
    
    @State var publicAccount: Bool
    
    @State var settingsAlert: SettingsAlert = .deleteAccount
    
    var body: some View {
        if(userViewModel.state == .signedIn){
            if userViewModel.user.username != "" {
                Text(userViewModel.user.username! + "'s Settings")
                    .frame(alignment: .center)
                    .font(Font.custom("DMSans-Medium", size: 30))
                    .foregroundColor(Color("AnimGreen"))
            } else {
                Text("Settings")
                    .frame(alignment: .center)
                    .font(Font.custom("DMSans-Medium", size: 30))
                    .foregroundColor(Color("AnimGreen"))
            }
        } else {
            Text("Login")
                .frame(alignment: .center)
                .font(Font.custom("DMSans-Medium", size: 30))
                .foregroundColor(Color("AnimGreen"))
        }
        VStack(alignment: .center){
            Spacer()
            Image(uiImage: UIImage(named: "animLogoIconGreen") ?? UIImage())
                .resizable()
                .frame(width: 120, height: 120)
            VStack {
                Text("Dark Mode")
                    .font(Font.custom("DMSans-Medium", size: 15))
                Toggle("DarkMode", isOn: $darkMode).labelsHidden()
                    .tint(Color("AnimGreen"))
            }
            .padding()
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color("AnimGreen"), lineWidth: 3))
            Spacer()
                .frame(height: 20)
            if(userViewModel.state == .signedOut){
                
                VStack{
                    //APPLE SIGN IN
                    SignInWithAppleButton { (request) in
                        //requesting parameters from apple login
                        userViewModel.nonce = randomNonceString()
                        request.requestedScopes = [.email, .fullName]
                        request.nonce = sha256(userViewModel.nonce)
                    } onCompletion: { (result) in
                        switch result{
                        case .success(let user):
                            guard let credential  = user.credential as? ASAuthorizationAppleIDCredential else {
                                print("error with firebase")
                                return
                            }
                            userViewModel.authenticate(credential: credential) { data in
                                userViewModel.user = data!
                                FirestoreRequests().getNutrition(data!.uid!) { data in
                                    userViewModel.nutrition = data!
                                }
                                profileMenuViewModel.icon = .user
                                defaults.set(userViewModel.user.uid!, forKey: "uid")
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                    .signInWithAppleButtonStyle(.whiteOutline)
                    .frame(width: UIScreen.screenWidth - 36, height: 40)
                    .clipShape(Rectangle())
                    //GOOGLE SIGN IN
                    GoogleSignInButton()
                        .onTapGesture {
                            userViewModel.signIn() { data in
                                userViewModel.user = data!
                                FirestoreRequests().getNutrition(data!.uid!) { data in
                                    userViewModel.nutrition = data!
                                }
                                profileMenuViewModel.icon = .user
                                defaults.set(userViewModel.user.uid!, forKey: "uid")
                            }
                        }
                }
            }
            else {
                if let madeUsername = userViewModel.user.hasSetUsername {
                    if userViewModel.state == .signedIn && madeUsername {
                        VStack {
                            Text("Make Account Public")
                                .font(Font.custom("DMSans-Medium", size: 15))
                            Toggle("DarkMode", isOn: $publicAccount).labelsHidden()
                                .tint(Color("AnimGreen"))
                        }
                    }
                }
                Button(action: {
                    userViewModel.signOut()
                    
                    NotificationCenter.default.post(name: NSNotification.signInStateChange, object: nil)
                    
                    userViewModel.user = User(uid: "", username: "", email: "", productsFromSearch: 0, productsScanned: 0, productsViewed: [], likes: [], dislikes: [], favorites: [], allergens: [], recentSearches: [], anim: "default")
                    
                    defaults.set(false, forKey: "signedIn")
                    
                    defaults.set(nil, forKey: "uid")
                    
                    defaults.set("default", forKey: "anim")
                    
                    //may not need
                    profileMenuViewModel.icon = .settings
                }, label: {
                    Text("Log Out")
                        .font(Font.custom("DMSans-Medium", size: 20))
                        .foregroundColor(Color("background"))
                        .lineLimit(1)
                })
                .padding()
                .background(Color("AnimGreen"))
                .cornerRadius(15)
                .clipShape(Capsule())
                
                Button {
                    showAlert.toggle()
                    settingsAlert = .deleteAccount
                } label: {
                    Text("Delete Account")
                        .font(Font.custom("DMSans-Medium", size: 20))
                        .foregroundColor(Color("background"))
                        .lineLimit(1)
                }
                .padding()
                .background(.red)
                .cornerRadius(15)
                .clipShape(Capsule())
            }
            Spacer()
            Link("Icons by Icons8",
                 destination: URL(string: "https://icons8.com")!)
            .font(Font.custom("DMSans-Medium", size: 13))
            .padding(.bottom, 50)
        }
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity
        )
        .alert(isPresented: $showAlert) {
            switch settingsAlert {
            case .deleteAccount:
                return Alert(
                    title: Text("Are you sure?"),
                    message: Text("You will lose all of the data associated with your account."),
                    primaryButton: .default(
                        Text("Keep Account"),
                        action: {showAlert.toggle()}
                    ),
                    secondaryButton: .destructive(
                        Text("Delete Account"),
                        action: deleteAccount
                    )
                )
            case .publicAccount:
                return Alert(
                    title: Text("Make your account public?"),
                    message: Text("All users will be able to see your posts and your profile."),
                    primaryButton: .default(
                        Text("Yes"),
                        action: {showAlert.toggle()
                            publicUser()
                        }
                    ),
                    secondaryButton: .destructive(
                        Text("No"),
                        action: {
                            showAlert.toggle()
                            publicAccount = false
                        }
                    )
                )
            case .privateAccount:
                return Alert(
                    title: Text("Make your account private?"),
                    message: Text("Only approved followers will be able to see your posts and your profile."),
                    primaryButton: .default(
                        Text("Yes"),
                        action: {showAlert.toggle()
                            privateUser()
                        }
                    ),
                    secondaryButton: .destructive(
                        Text("No"),
                        action: {
                            showAlert.toggle()
                            publicAccount = true
                        }
                    )
                )
            }
        }
        .onChange(of: publicAccount) { value in
            showAlert.toggle()
            if publicAccount {
                settingsAlert = .publicAccount
            }
            else {
                settingsAlert = .privateAccount
            }
        }
    }
    
    func deleteAccount() {
        userViewModel.deleteAccount()
        FirestoreRequests().deleteAccount(uid: userViewModel.user.uid!)
        showAlert.toggle()
        userViewModel.user = User(uid: "", username: "", email: "", productsFromSearch: 0, productsScanned: 0, productsViewed: [], likes: [], dislikes: [], favorites: [], allergens: [], recentSearches: [], anim: "default")
        
        defaults.set(false, forKey: "signedIn")
        
        defaults.set(nil, forKey: "uid")
        
        defaults.set("default", forKey: "anim")
        
        
        
        //may not need
        profileMenuViewModel.icon = .settings
    }
    
    func publicUser() {
        userViewModel.user.isPublic! = true
        FirestoreRequests().publicUser(uid: userViewModel.user.uid!)
    }
    func privateUser() {
        userViewModel.user.isPublic! = false
        FirestoreRequests().privateUser(uid: userViewModel.user.uid!)
    }
}
