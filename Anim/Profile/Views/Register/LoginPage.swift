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
struct LoginPage: View {
    
    let defaults = UserDefaults.standard
    
    @EnvironmentObject var userViewModel: UserViewModel
    
    @EnvironmentObject var profileMenuViewModel: ProfileMenuViewModel
    
    var body: some View {
        if(userViewModel.state == .signedIn){
            if userViewModel.userModel.username != "" {
                Text(userViewModel.userModel.username! + "'s Settings")
                    .frame(alignment: .center)
                    .font(.system(size: 30))
                    .fontWeight(.bold)
            } else {
                Text("Settings")
                    .frame(alignment: .center)
                    .font(.system(size: 30))
                    .fontWeight(.bold)
            }
        } else {
            Text("Login")
                .frame(alignment: .center)
                .font(.system(size: 30))
                .fontWeight(.bold)
        }
        VStack(alignment: .center){
            Spacer()
            Image(uiImage: UIImage(named: "AppIcon") ?? UIImage())
                .resizable()
                .frame(width: 120, height: 120)
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
                            print("success")
                            guard let credential  = user.credential as? ASAuthorizationAppleIDCredential else {
                                print("error with firebase")
                                return
                            }
                            userViewModel.authenticate(credential: credential) { data in
                                userViewModel.userModel = data!
                                profileMenuViewModel.icon = .user
                                defaults.set(userViewModel.userModel.uid!, forKey: "uid")
                            }
                        case .failure(let error):
                            print(error.localizedDescription)
                        }
                    }
                    .signInWithAppleButtonStyle(.black)
                    .frame(width: UIScreen.screenWidth - 36, height: 40)
                    .clipShape(Rectangle())
                    //GOOGLE SIGN IN
                    GoogleSignInButton()
                        .onTapGesture {
                            userViewModel.signIn() { data in
                                userViewModel.userModel = data!
                                profileMenuViewModel.icon = .user
                                defaults.set(userViewModel.userModel.uid!, forKey: "uid")
                            }
                        }
                }
            }
            else {
                Button(action: {
                    userViewModel.signOut()
                    
                    NotificationCenter.default.post(name: NSNotification.signInStateChange, object: nil)
                    
                    userViewModel.userModel = UserModel(uid: "", username: "", email: "", productsFromSearch: 0, productsScanned: 0, productsViewed: [], likes: [], dislikes: [], favorites: [], allergens: [], recentSearches: [], anim: "default")
                    
                    defaults.set(false, forKey: "signedIn")
                    
                    defaults.set(nil, forKey: "uid")
                    
                    
                    //may not need
                    profileMenuViewModel.icon = .settings
                }, label: {
                    Text("Log Out")
                        .foregroundColor(.white)
                        .fontWeight(.heavy)
                        .lineLimit(1)
                })
                .padding()
                .background(.green)
                .cornerRadius(15)
                .clipShape(Capsule())
            }
            Spacer()
            Link("Icons by Icons8",
                  destination: URL(string: "https://icons8.com")!)
                .padding(.bottom, 50)
        }
        .frame(
            minWidth: 0,
            maxWidth: .infinity,
            minHeight: 0,
            maxHeight: .infinity
        )
        
    }
    
    
}

struct LoginPage_Previews: PreviewProvider {
    static var previews: some View {
        LoginPage()
    }
}
